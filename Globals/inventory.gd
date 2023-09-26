extends Spatial  ## Inventory ##

signal added_item(item_data)
signal removed_item(item_data)

var items = []


func add_item(item_data:Dictionary, override: bool):
	for i in items:
		#check if item already exists in inventory
		if i.data.id == item_data.id:
			if !override:
				item_data['id'] = Utils.generate_id()
			else:
				items.remove(items.find(i))
	var path
	path = str("res://item/components/custom_components/starter_",item_data.class_,".tscn") if item_data.class_ != 'build' else str("res://item/build/build.tscn")
	var new_item = load(path).instance()
	new_item.data = item_data
#	if new_item is Build: new_item.added_components = new_item.data.added_components
	items.append(new_item)
	emit_signal("added_item",new_item.data)


func remove_item(item_data):
	for i in items:
		if i.data.id == item_data.id:
			items.remove(items.find(i))
			emit_signal("removed_item",item_data)
			return


func get_item_from_dict(data:Dictionary) -> Item:
	var item
	for i in items:
		if i.data.id == data.id:
			item = i
	return item
