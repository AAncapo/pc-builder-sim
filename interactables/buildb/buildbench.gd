class_name BuildBench extends Interactable

onready var bbase := $"%buildBase"

var dragging := false
var current_bp setget set_current_build
func set_current_build(value):
	current_bp = value
	ui_control._update(current_bp)
var request_db = preload("res://request/RequestDatabase.tres")


func _ready():
	Events.connect("request_accepted",self, "_on_request_accepted")
	Events.connect("request_completed",self, "_on_request_completed")


func _process(_delta):
	if ui_control.visible:
		dragging = Input.is_action_pressed("rotate_item")

func _unhandled_input(event):
	if event is InputEventMouseMotion && dragging && current_bp:
		current_bp.rotate_y(deg2rad(event.relative.x * 0.8))
		current_bp.rotation_degrees.y = wrapf(current_bp.rotation_degrees.y, 0.0, 360.0)


func _on_request_accepted(req):
	create_new_build(req)
	request_db.accepted_requests.append(req)


func _on_request_completed(req):
	for ar in request_db.accepted_requests:
		if ar == req:
			request_db.completed_requests.append(ar)
			request_db.accepted_requests.remove(request_db.accepted_requests.find(ar))
			if current_bp.data['request'] == req:
				#TODO: send to client
				current_bp.data['request'].client.posted_request = false
				Inventory.remove_item(current_bp)
				self.current_bp = null


func _on_BuildModeUI_start_new_build():
	create_new_build(BuildRequest.new())


func create_new_build(req:BuildRequest):
	var bdata = {}
	bdata.id = Utils.generate_id()
	bdata.class_ = 'build'
	bdata.required_components = {'case':{}}
	var name_ = str(req.client.name_,"'s ",req.get_request_class(),' PC') if req.client else 'New Custom Build'
	bdata.name_ = name_
	bdata.request = req
	
	var build = load("res://item/build/build.tscn").instance()
	bbase.add_child(build)
	build.data = bdata
	Inventory.add_item(bdata,true)


func _on_BuildModeUI_build_selected(bdict):
	var builds = bbase.get_children()
	# show selected build and hide the rest #
	for b in builds:
		b.visible = bdict.id == b.data.id
		# set selected as the current_build #
		if b.visible: self.current_bp = b


func _on_BuildModeUI_component_selected(cdict):
	if current_bp:
		if current_bp.install_component(cdict):
			current_bp.added_components.append(cdict)
		ui_control._update(current_bp)
