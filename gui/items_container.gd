extends VBoxContainer
# items container #
onready var list =$ScrollContainer/list
var items_owner

func add_item(item_button:Control):
	list.add_child(item_button)

func get_items():
	return list.get_children()

func remove_items():
	Utils.remove_all_children(list)

func _on_filter_button__pressed(button):
	var tag = button.text.to_lower()
	
	var ibs = get_items()
	for ib in ibs:
		if tag == 'builds':
			ib.visible = ib.item_linked.item_class == 'build'
		if tag == 'components':
			ib.visible = ib.item_linked.item_class != 'build'
		
