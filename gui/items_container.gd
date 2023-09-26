class_name ItemContainer extends VBoxContainer

onready var list = $"%button_list"
var linkedButton = preload("res://gui/linked_button.tscn")
var items_owner


func add_item(item:Dictionary, bdisplay_mode=0) -> LinkedButton:
	var button = linkedButton.instance()
	button.item_linked = item
	list.add_child(button)
	button.display_mode = bdisplay_mode
	return button


func get_items() -> Array:
	return list.get_children()

func remove_items() -> void:
	Utils.remove_all_children(list)
