class_name Workbench extends Interactable

onready var bholder := $build_holder
var dragging := false
var active_build setget setActiveBuild
func setActiveBuild(value):
	active_build = value
	ui._update(active_build)
	if active_build == null:
		for b in bholder.get_children():
			if b.visible: b.queue_free()
var request_db = preload("res://request/RequestDatabase.tres")


func _ready():
	Events.connect("request_accepted",self, "_on_request_accepted")
	Events.connect("request_completed",self, "_on_request_completed")
	Events.connect("item_uploaded",self,"_on_item_uploaded")
	
	ui._update(active_build)


func _process(_delta):
	if ui.visible:
		dragging = Input.is_action_pressed("rotate_item")

func _unhandled_input(event):
	if event is InputEventMouseMotion && dragging && active_build:
		bholder.rotate_y(deg2rad(event.relative.x * 0.8))
		bholder.rotation_degrees.y = wrapf(bholder.rotation_degrees.y, 0.0, 360.0)


func _on_BuildModeUI_start_new_build():
	create_new_build(BuildRequest.new())


func create_new_build(req:BuildRequest):
	var bdata = {}
	bdata.id = Utils.generate_id()
	bdata.class_ = 'build'
	bdata.required_components = {'case':{}}
	var name_ = str(req.client.name_,"'s ",req.get_request_class(),' PC') if req.client else 'New Custom Build'
	bdata.name_ = name_
	bdata.initial_price = 0.00
	bdata.request = req
	
	Inventory.add_item(bdata,true)
	var build = Inventory.get_item_from_dict(bdata)
	bholder.add_child(build)


func _on_BuildModeUI_build_selected(bdict):
	var builds = bholder.get_children()
	# show selected build and hide the rest #
	for b in builds:
		b.visible = bdict.id == b.data.id
		# set selected as the current_build #
		if b.visible: self.active_build = b


func _on_BuildModeUI_component_selected(cdict):
	if active_build:
		if active_build.install_component(cdict):
			active_build.added_components.append(cdict)
		ui._update(active_build)


func _on_request_accepted(req):
	create_new_build(req)
	request_db.accepted_reqs.append(req)


func _on_request_completed(req):
	for ar in request_db.accepted_reqs:
		if ar == req:
			request_db.completed_reqs.append(ar)
			request_db.accepted_reqs.remove(request_db.accepted_reqs.find(ar))
			if active_build.data['request'] == req:
				#TODO: send to client
				active_build.data['request'].client.posted_request = false
				Inventory.remove_item(active_build.data)
				self.active_build = null


func _on_item_uploaded(data):
	if data.class_ == 'build' && data.id == active_build.data.id:
		self.active_build = null
