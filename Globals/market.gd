extends Node
## Market ##

var manufactors = []
var world_items = {
	#item_class : [all_items]
	}
var clients = []
var player_balance: float = 1000.00


func _ready():
	randomize()
	manufactors = [
		CpuManufactor.new(),
		MoboManufactor.new(),
		CaseManufactor.new(),
		MemManufactor.new(),
		PsuManufactor.new(),
		StorageManufactor.new(),
		CoolerManufactor.new(),
		]
	for m in manufactors:
		world_items[m.component_class] = m.generate_components(20)
	
	clients.append(generate_client())
	#TODO: use wait until tree is ready function
	yield(get_tree().create_timer(1.0),"timeout")
	
	for cl in clients:
		cl.generate_request()


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


func generate_client() -> Client:
	var client = Client.new()
	client.name_ = rnames[randi()%rnames.size()]
	client.budget = floor(rand_range(500,1000))
	return client


func get_client() -> Client:
	for cl in clients:
		if !cl.posted_request:
			return cl
	var client = generate_client()
	clients.append(client)
	return client


var rnames = ['Riri','Linus','Yon','Kiba89','Ancapo','Stiv','Jay','Arnold S.', 'Drake','Marshall','Ye']
