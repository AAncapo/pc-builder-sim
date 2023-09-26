extends Control

onready var component_list = $"%comp_bc"
onready var build_list = $"%build_bc"


func _ready():
	Inventory.connect("added_item",self,"_on_item_added")
	Inventory.connect("removed_item",self,"_on_item_removed")
	Events.connect("component_installed",self,"_on_component_installed")


func _on_item_added(new_item):
	var button:LinkedButton
	if new_item.class_ == 'build':
		button = build_list.add_item(new_item)
	else:
		button = component_list.add_item(new_item)
	button.connect("_pressed",self,"_on_button_pressed")


func _on_button_pressed(button):
	match button.item_linked.class_:
		'build': owner.emit_signal("build_selected",button.item_linked)
		_:
			owner.emit_signal("component_selected",button.item_linked)


func _on_item_removed(item_data):
	var list = component_list if item_data.class_ != 'build' else build_list
	for b in list.get_items():
		if b.item_linked.id == item_data.id:
			b.queue_free()
			return


func _on_component_installed(cdata):
	var components = component_list.get_items()
	for c in components:
		if c.item_linked.id == cdata.id:
			Inventory.remove_item(cdata)


func _on_builds_bttn_pressed():
	$"%build_bc".visible = !$"%build_bc".visible

func _on_components_bttn_pressed():
	$"%comp_bc".visible = !$"%comp_bc".visible
