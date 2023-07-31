extends Control
## Create build project ##
	# press new_project button calls confirmationDialog,
	# write project's name. confirm. emit(create_new_project) -> buildbench
	# buildbench. create new BuildProject and calls self.add_project to add in the pj_list
## Open project ##
	# press bp_button in pj_list emit(build_project_selected) -> buildbench
	# buildbench. set current_bp as the opened project and calls self.update_build_details()


signal build_project_selected(bp)
signal create_new_project(pj_name)

onready var buildDetails := $build_details
onready var buildSelector := $build_selector
var bp_button_temp = preload("res://gui/bp_button.tscn")


func _ready():
	display_panel(buildSelector)


func add_project(project):
	var button = bp_button_temp.instance()
	button.bp_linked = project
	$"%pj_list".add_child(button)
	
	button.connect("_pressed",self, "open_project")


func open_project(bp):
	display_panel(buildDetails)
	emit_signal("build_project_selected",bp)


func update_build_details(bp:BuildProject):
	var required_list := $"%required"
	for r in required_list.get_children():
		r.queue_free()
	
	$"%pj_name".text = str(bp.project_name)
	
	for key in bp.r_components:
		var cbox:= CheckBox.new()
		cbox.text = str(key)
		
		cbox.pressed = bp.r_components[key]['completed']
		required_list.add_child(cbox)


func display_panel(gui_node):
	if gui_node == buildDetails:
		buildDetails.show()
		buildSelector.hide()
	else:
		buildSelector.show()
		buildDetails.hide()


func _on_new_project_pressed():
	$"%ConfirmationDialog".popup()
	$"%LineEdit".grab_focus()

func _on_ConfirmationDialog_confirmed():
	emit_signal("create_new_project",$"%LineEdit".text)

func _on_back_pressed():
	display_panel(buildSelector)
