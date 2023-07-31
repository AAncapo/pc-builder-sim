extends ScrollContainer
# items container #

func add_items(item_button):
	$VBoxContainer.add_child(item_button)

func get_items():
	return $VBoxContainer.get_children()
