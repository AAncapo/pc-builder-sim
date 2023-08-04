extends ScrollContainer
# items container #
var items_owner

func add_items(item_button):
	$VBoxContainer.add_child(item_button)

func get_items():
	return $VBoxContainer.get_children()
