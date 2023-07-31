class_name Inventory extends Resource

var stored_items = []

func _init():
	Events.connect("added_item_to_inv", self, "add_item")
	Events.connect("removed_item_from_inv", self, "remove_item")

func add_item(item:Item):
	stored_items.append(item)

func remove_item(item:Item):
	stored_items.remove(stored_items.find(item))
