class_name BuildBench extends Interactable

onready var bp_pos := $"%bp_pos"
onready var builds_gui := $"%builds"
var build_proj_template = preload("res://build_project/build_project.tscn")
var is_active := false
var dragging := false
var current_bp: BuildProject


func _process(delta):
	$buildbench_gui.visible = is_active
	if is_active:
		dragging = Input.is_action_pressed("rotate_item")


func _unhandled_input(event):
	if event is InputEventMouseMotion && dragging:
		current_bp.rotate_y(deg2rad(event.relative.x * 0.8))
		current_bp.rotation_degrees.y = wrapf(current_bp.rotation_degrees.y, 0.0, 360.0)

func interact():
	is_active = true

func exit():
	is_active = false


func _on_builds_create_new_project(pj_name):
	var new_project:BuildProject = build_proj_template.instance()
	new_project.id = Utils.generate_id()
	new_project.project_name = str(pj_name)
	builds_gui.add_project(new_project)
	
	bp_pos.add_child(new_project)


func _on_components_gui_install_component(component):
	if current_bp:
		#check if current_bp can add component
		if current_bp.add_component(component):
			builds_gui.update_bp_details(current_bp)


func _on_builds_build_project_selected(bp):
	current_bp = bp
	for bp in bp_pos.get_children():
		bp.visible = bp == current_bp
	builds_gui.update_bp_details(current_bp)


func _on_builds_uninstalled_component(component_key):
	if current_bp.remove_component(component_key):
		builds_gui.update_bp_details(current_bp)
