class_name ItemsPackage extends MeshInstance

export (Array, PackedScene) var custom_items = []
export (String) var sender
export (String) var pckg_name
onready var pckg_items = $items


func _ready():
	if !custom_items.empty():
		create_new_package(custom_items)


func create_new_package(_items: Array):
	for i in _items:
		var new_item = i.instance()
		pckg_items.add_child(new_item)
