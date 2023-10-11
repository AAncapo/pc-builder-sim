class_name ItemContainer extends Control

export (float) var max_size_y = 400.0
onready var list = $"%button_list"
var linkedButton = preload("res://gui/linked_button.tscn")
var items_owner

func _ready():
	_update_rect()


func add_item(item:Dictionary, bdisplay_mode=0) -> LinkedButton:
	var button = linkedButton.instance()
	button.item_linked = item
	list.add_child(button)
	list.move_child(button,0)
	button.display_mode = bdisplay_mode
#	button.connect("_mouse_enter",self,"_on_button_mouse_enter")
#	button.connect("_mouse_exit",self,"_on_button_mouse_exit")
	_update_rect()
	return button


func _update_rect():
	if list.rect_size.y <= max_size_y:
		$ScrollContainer.rect_min_size.y = list.rect_size.y

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
	_update_rect()
	$empty_list.visible = get_items().empty()
	$empty_list.text = 'Empty :/'
