extends Control

onready var component_list = $"%comp_bc"
onready var build_list = $"%build_bc"
var button_temp = preload("res://gui/item_button.tscn")


func _ready():
	Inventory.connect("added_item",self,"_on_item_added")
	Inventory.connect("removed_item",self,"_on_item_removed")


func _on_item_added(new_item):
	var button = button_temp.instance()
	button.item_linked = new_item
	if new_item.class_ == 'build':
		build_list.add_item(button)
	else:
		component_list.add_item(button)
	button.connect("_pressed",self,"_on_button_pressed")
	

func _on_button_pressed(button):
	match button.item_linked.class_:
		'build': owner.emit_signal("build_selected",button.item_linked)
		_:
#			button.disabled = true
			owner.emit_signal("component_selected",button.item_linked)


func _on_item_removed(item_data):
	var list = component_list if item_data.item_class != 'build' else build_list
	for b in list.get_items():
		if b.item_linked.id == item_data.id:
			b.queue_free()
			return


func _on_builds_bttn_pressed():
	$"%build_bc".visible = !$"%build_bc".visible


func _on_components_bttn_pressed():
	$"%comp_bc".visible = !$"%comp_bc".visible
