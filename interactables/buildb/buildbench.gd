class_name BuildBench extends Interactable

onready var bp_pos := $"%bp_pos"
onready var builds_gui := $"%builds"
var build_temp = preload("res://item/build/build.tscn")
var is_active := false
var dragging := false
var current_bp: Build


func _process(_delta):
	$buildbench_gui.visible = is_active
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


func _on_components_gui_install_component(component):
	if current_bp:
		#check if current_bp can add component
		if current_bp.add_component(component):
#			builds_gui.update_bp_details(current_bp)
			if current_bp.is_completed():
				if current_bp.category == 'requested':
					$"%send_button".show()


func _on_create_new_project(pj_name, br):
	var new_project: Build = build_temp.instance()
	new_project.id_ = Utils.generate_id()
	new_project.name_ = str(pj_name)
	
	new_project.category = 'personal'
	if br:
		new_project.category = 'requested'
	
	$buildbench_gui/builds.add_project(new_project)
	bp_pos.add_child(new_project)


func _on_build_project_selected(bp):
	current_bp = bp
	for bp in bp_pos.get_children():
		bp.visible = bp == current_bp
#	builds_gui.update_bp_details(current_bp)


func _on_uninstalled_component(component_key):
	if current_bp.remove_component(component_key):
#		builds_gui.update_bp_details(current_bp)
		if current_bp.is_completed():
			if current_bp.category == 'requested':
				$"%send_button".hide()


func _on_send_button_pressed():
	if current_bp.category=='requested':
		builds_gui.remove_project_button(current_bp)
		current_bp.queue_free()
#		builds_gui.update_bp_details(null)
		$"%send_button".hide()
