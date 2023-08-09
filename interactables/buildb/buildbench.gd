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


func _on_create_new_project(br:BuildRequest = null):
	var build: Build = build_temp.instance()
	var build_dict = build.build_data
	if br:
		build_dict.name_ = br.client.name_ 
		build_dict.category = 'requested'
	else:
		build_dict.name_ = ''
		build_dict.category = 'personal'
	build_dict.id = str(build_dict.category,'-',Utils.generate_id())
	
	$buildbench_gui/builds.add_project(build)
	
	bp_pos.add_child(build)
	_on_build_project_selected(build)


func _on_build_project_selected(bp):
	current_bp = bp
	for bp in bp_pos.get_children():
		bp.visible = bp == current_bp


func _on_uninstalled_component(component_key):
	if current_bp.remove_component(component_key):
		if current_bp.is_completed():
			if current_bp.build_data.category == 'requested':
				$"%send_button".hide()


func _on_send_button_pressed():
	if current_bp.category=='requested':
		builds_gui.remove_project_button(current_bp)
		current_bp.queue_free()
		$"%send_button".hide()


func _on_builds_rename_build(new_name):
	current_bp.name_ = new_name
	current_bp.status_view.update_pc_status(current_bp)


func _on_inventory_gui_install_component(component_data):
	if current_bp:
		#check if current_bp can add component
		if current_bp.add_component(component_data):
			if current_bp.is_completed():
				if current_bp.category == 'requested':
					$"%send_button".show()
