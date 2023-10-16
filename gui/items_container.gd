class_name ItemContainer extends Control

onready var list = $"%button_list"
var linkedButton = preload("res://gui/linked_button.tscn")


func add_item(item:Dictionary) -> LinkedButton:
	var button = linkedButton.instance()
	button.item_linked = item
	list.add_child(button)
	list.move_child(button,0)
#	button.connect("_mouse_enter",self,"_on_button_mouse_enter")
#	button.connect("_mouse_exit",self,"_on_button_mouse_exit")
	return button


func get_items() -> Array:
	return list.get_children()

func remove_items() -> void:
	Utils.remove_all_children(list)

func get_visible_items():
	for b in get_items():
		if b.visible: 
			$empty_list.hide()
			return
	$empty_list.show()

func _on_button_list_sort_children():
	$empty_list.visible = get_items().empty()
	$empty_list.text = 'Empty :/'
