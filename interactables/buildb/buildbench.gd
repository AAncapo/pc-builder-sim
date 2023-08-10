class_name BuildBench extends Interactable

onready var bbase := $"%buildBase"
var is_active := false
var dragging := false
var current_bp: Build


func _process(_delta):
	$bb_gui.visible = is_active
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


func _on_inventory_gui_item_selected(component_data):
	
	if component_data.item_class == 'build':
		for b in bbase.get_children():
			if component_data.id == b.data.id:
				b.visible = !b.visible
				return
		var build = Inventory.get_as_item(component_data)
		Utils.change_parent(build, bbase)
		current_bp = build
		return
	else:
		if current_bp:
			current_bp.add_component(component_data)


func _on_new_project_pressed():
	var build_data = {}
	build_data.item_class = 'build'
	build_data.id = str(Utils.generate_id())
	build_data.name_ = 'New Build'
	build_data.category = 'personal'
	
	Inventory.emit_signal("added_item",build_data,true)
