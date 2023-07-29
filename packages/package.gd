class_name Package extends MeshInstance

export (Array, PackedScene) var custom_items = []
export var sender := 'Personal'

onready var items_holder = $items


func _ready():
	if !custom_items.empty():
		create_new_package(custom_items)


func create_new_package(_items: Array):
	for i in _items:
		var new_item = i.instance()
		items_holder.add_child(new_item)


func get_items():
	return items_holder.get_children()
