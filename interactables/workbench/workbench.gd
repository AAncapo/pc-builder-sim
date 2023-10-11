class_name WorkBench extends Interactable

onready var bbase := $"%buildBase"
var builds setget ,getBuilds
func getBuilds(): return bbase.get_children()
var dragging := false
var active_build:Build = null setget setActiveBuild
func setActiveBuild(value):
	if value == null:
		if active_build: active_build.queue_free()
	else:
		for b in self.builds:
			b.visible = b==value
	active_build = value
var request_db = preload("res://request/RequestDatabase.tres")


func _ready():
	Events.connect("request_accepted",self, "_on_request_accepted")
	Events.connect("request_completed",self, "_on_request_completed")
	Events.connect("item_uploaded",self,"_on_item_uploaded")


func _process(_delta):
	if ui.visible:
		dragging = Input.is_action_pressed("rotate_item")

func _unhandled_input(event):
	if event is InputEventMouseMotion && dragging && active_build:
		active_build.rotate_y(deg2rad(event.relative.x * 0.8))
		active_build.rotation_degrees.y = wrapf(active_build.rotation_degrees.y, 0.0, 360.0)


func _on_BuildModeUI_start_new_build():
	create_new_build()


func create_new_build():
	var bdata = BuildGenerator.generate_build(true)
	bdata.name_ = 'New Custom Build'
	Inventory.add_item(bdata,true)


func select_build(bdict):
	## New empty build ##
	# set as active build if already exists in bbase #
	for b in self.builds:
		if b.data.id == bdict.id:
			self.active_build = b
			return
	## Client build ##
	# instantiate build in bbase if doesnt exists yet #
	var new_build = Inventory.get_item_from_dict(bdict)
	Utils.change_parent(new_build,bbase)
	self.active_build = self.builds[self.builds.find(new_build)]


func select_component(cdict):
	if active_build:
		if active_build.install_component(cdict,active_build):
			active_build.added_components.append(cdict)


func _on_request_accepted(req):
#	create_new_build()
	# buildbench doesnt create 'build bases' for buildRequests anymore
	# first create a build and then use the sender button to decide which client should receive it
	request_db.accepted_reqs.append(req) #TODO: remove this from bbench (maybe)


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


func _on_workbench_ui_item_selected(dict:Dictionary):
	if dict.class_ == 'build': select_build(dict) 
	else: select_component(dict)
