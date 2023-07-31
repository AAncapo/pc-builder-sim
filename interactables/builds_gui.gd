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
signal uninstalled_component(component_key)

onready var buildDetails := $build_details
onready var buildSelector := $build_selector
var bp_button_temp = preload("res://gui/bp_button.tscn")
var rc_detail_temp = preload("res://gui/bp_rc_detail.tscn")


func _ready():
	display_panel(buildSelector)


func add_project(project):
	var button = bp_button_temp.instance()
	button.bp_linked = project
	$"%bpj_list".add_child(button)
	
	button.connect("_pressed",self, "open_project")


func open_project(bp):
	display_panel(buildDetails)
	emit_signal("build_project_selected",bp)


func update_bp_details(bp:BuildProject):
	var required_list := $"%required"
	for r in required_list.get_children():
		r.queue_free()
	
	$"%pj_name".text = str(bp.project_name)
	
	for key in bp.r_components:
		var rc_detail = rc_detail_temp.instance()
		var _pressed = bp.r_components[key]['completed']
		var _max = bp.r_components[key]['max']
		var _added = bp.r_components[key]['added']
		rc_detail.component_key_linked = key
		rc_detail.update_values(str(key), _pressed, _added, _max)
		
		required_list.add_child(rc_detail)
		
		if rc_detail.is_connected("uninstall", self,"_on_rc_uninstall_pressed"): return
		rc_detail.connect("uninstall", self, "_on_rc_uninstall_pressed")


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

func _on_rc_uninstall_pressed(component_key):
	emit_signal("uninstalled_component", component_key)


func _on_back_pressed():
	display_panel(buildSelector)
