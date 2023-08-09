extends Node  ## Market ##

#var item_classes = ['case','motherboard','cpu','cpu_cooler','ram','hdd','psu']
var world_items = {
	#item_class : [all_items]
}


func _ready():
	world_items.cpu = $manufactor.generate_cpu()
	world_items.motherboard = $manufactor.generate_mobo()
	world_items.case = $manufactor.generate_case()


func get_item(key=null):
	if key:
		return world_items[key][randi()%world_items[key].size()]
	
	var r_key = world_items.keys()[randi()%world_items.keys().size()]
	return world_items[r_key][randi()%world_items[r_key].size()]


func generate_starter_pckg():
	var items = []
	for i in world_items.keys():
		
		items.append(world_items.get(i)[0])
	return items
