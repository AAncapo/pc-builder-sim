extends Spatial  ## Inventory ##

signal added_item(item_data)
signal removed_item(item_data)

onready var item_nodes = $items
var items = [] #Item Nodes array


func add_item(item_data:Dictionary, override: bool):
	for i in items:
		#check if item already exists in inventory
		if i.id == item_data.id:
			if !override:
				item_data['id'] = Utils.generate_id()
			else:
				remove_item(item_data.id)
	var path
	path = str("res://item/components/custom_components/starter_",item_data.class_,".tscn") if item_data.class_ != 'build' else str("res://item/build/build.tscn")
	var new_item = load(path).instance()
	new_item.data = item_data
	
	items.append(new_item.data)
	item_nodes.add_child(new_item)
	
	emit_signal("added_item", new_item.data)


func remove_item(id):
	for i in items:
		if i.id == id:
			## remove from item dicts ##
			items.remove(items.find(i))
			for n in item_nodes.get_children():
				## remove from item_nodes
				if n.data.id == id: n.queue_free()
			emit_signal("removed_item",id)
			return


func get_item_from_dict(data:Dictionary) -> Item:
	var item: Item
	for i in item_nodes.get_children():
		if i.data.id == data.id:
			item = i
	return item
