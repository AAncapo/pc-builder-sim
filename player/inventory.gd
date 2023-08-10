extends Spatial  ## Inventory ##

signal added_item(item_dict, override)
signal removed_item(item)

onready var items = $items


func get_as_item(data):
	for i in items.get_children():
		if i.data.id == data.id:
			return i


func _on_inventory_added_item(item_dict, override):
	for i in items.get_children():
		if i.data.id == item_dict.id:
			if !override:
				item_dict.id = Utils.generate_id()
			else:
				i.queue_free()
	var path
	if item_dict.item_class != 'build':
		#TODO: also check if is from a client
		path = str("res://item/components/custom_components/starter_",item_dict.item_class,".tscn")
	else:
		path = "res://item/build/build.tscn"
	var packed_scn = load(path)
	var _item = packed_scn.instance()
	_item.data = item_dict
	$items.add_child(_item)


func _on_inventory_removed_item(item):
	for i in items.get_children():
		if i==item:
			i.queue_free()
			return
