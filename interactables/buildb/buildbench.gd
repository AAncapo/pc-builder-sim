class_name BuildBench extends Interactable

onready var bbase := $"%buildBase"
onready var binstalled := $"%b_installed_components"
onready var br_status := $"%request_status"
var is_active := false
var dragging := false
var current_bp: Build setget set_current_build
func set_current_build(value):
	current_bp = value
	if current_bp != null:
		br_status.current_build_data = current_bp.data
		for br in build_requests:
			if br.id == current_bp.data.id:
				binstalled.update_status(current_bp.data)
var build_requests = []


func _ready():
	Events.connect("request_accepted",self, "_on_request_accepted")


func _process(_delta):
	$build_mode_gui.visible = is_active
	if is_active:
		dragging = Input.is_action_pressed("rotate_item")


func _unhandled_input(event):
	if event is InputEventMouseMotion && dragging && current_bp:
		current_bp.rotate_y(deg2rad(event.relative.x * 0.8))
		current_bp.rotation_degrees.y = wrapf(current_bp.rotation_degrees.y, 0.0, 360.0)


func interact():
	is_active = true
func exit():
	is_active = false


func _on_buildmode_inventory_item_selected(component_data):
	if component_data.item_class == 'build':
		for b in bbase.get_children():
			b.visible = component_data.id == b.data.id
		
		for b in bbase.get_children():
			if b.visible: 
				self.current_bp = b
				binstalled.update_status(current_bp.data)
				return
	
		var build = Inventory.get_item_from_dict(component_data)
		Utils.change_parent(build, bbase)
		self.current_bp = build
		return
	else:
		if current_bp:
			current_bp.add_component(component_data)
			#update build info ui
			binstalled.update_status(current_bp.data)
	
	#update request status ui
	br_status.current_build_data = current_bp.data


func create_new_build(client:wClient=null):
	var bdata = {}
	bdata.item_class = 'build'
	bdata.id = str(Utils.generate_id())
	
	if client:
		bdata.name_ = str(client.name_,"'s ",client.request.get_request_class(),' PC')
		bdata.request = client.request
	else:
		bdata.name_ = 'New Custom Build'
		var r = BuildRequest.new()
		r.request_class = r.RequestClass.Undefined
		r.id = Utils.generate_id()
		bdata.request = r
	Inventory.emit_signal("added_item",bdata,true)


func _on_new_project_pressed():
	create_new_build()


func _on_request_accepted(post:wRequestPost):
	create_new_build(post._client)
	build_requests.append(post._client.request)
