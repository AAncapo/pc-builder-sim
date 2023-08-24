extends Node  ## Market ##

onready var manufactr = $manufactor
var world_items = {
	#item_class : [all_items]
	}
var clients = []


func _ready():
	world_items.cpu = manufactr.generate_cpu()
	world_items.motherboard = manufactr.generate_mobo()
	world_items.case = manufactr.generate_case()
	world_items.hdd = manufactr.generate_hdd()
	world_items.psu = manufactr.generate_psu()
	world_items.ram = manufactr.generate_ram()
	world_items.cooler = manufactr.generate_cooler()
	
	for i in range(10):
		clients.append(generate_client())


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


func generate_client():
	var client = wClient.new()
	client.name_ = rnames[randi()%rnames.size()]
	client.budget = floor(rand_range(500,2000))
	return client


func get_client():
	for cl in clients:
		if !cl.posted_request:
			return cl
	var client = generate_client()
	clients.append(client)
	return client


var rnames = ['Riri','Linus','Yon','Kiba89','Ancapoo','Stiv','Jay','Arnold S.', 'Drake','Marshall','Luda']
