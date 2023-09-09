extends Spatial  ## Inventory ##

signal added_item(item_data)
signal removed_item(item_data)

var items = []


func add_item(item:Dictionary, override: bool):
	for i in items:
		if i.id == item.id:
			if !override:
				item['id'] = Utils.generate_id()
			else:
				i.queue_free()
	items.append(item)
	
	emit_signal("added_item",item)


func remove_item(item_data):
	for i in items:
		print(i.data.id,' ',item_data.id)
		if i.data.id==item_data.id:
			i.queue_free()
			emit_signal("removed_item",item_data)
			print('removed')
			return
