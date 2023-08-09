class_name Build extends Item

signal component_not_supported
signal component_max_reached

onready var case_slot := $"s-case"
onready var status_view := $Status
var name_:String
var category:String
var build_data = {}

var rc: Dictionary = {
	'case': { 'required':1,'added':0,'max':1,'completed':false },
	'motherboard': { 'required':1,'added':0,'max':1,'completed':false },
	'ram': { 'required':1,'added':0,'max':1,'completed':false },
	'cpu': { 'required':1,'added':0,'max':1,'completed':false },
	'cpu_fan': {'required':1,'added':0,'max':1,'completed':false },
	'hdd': { 'required':1,'added':0,'max':1,'completed':false },
	'psu': { 'required':1,'added':0,'max':1,'completed':false },
}


func _ready():
	status_view.update_pc_status(self)


func add_component(item_data:Dictionary) -> bool:
	##TODO: get component data as object
	var cc = item_data.item_class
	if !rc.has(cc):
		#TODO: make in-game notification
		emit_signal("component_not_supported")
		print("ERROR!: This build do not REQUIRE or SUPPORT this component: ",cc,".")
		return false
	## check-add if hasnt reached max ##
	if (rc.get(cc)['added'] < rc.get(cc)['max']):
		
		## set HDD/RAM max ##
		if cc == 'case':
			rc.hdd['max'] = item_data.hdd_slots
		if cc == 'motherboard':
			rc.case['max'] = item_data.ram_slots
		
		## REJECT component if case/mboard havent been added ##
		if cc!='case' && rc.case['added'] < 1:
			return false
		if cc!='motherboard' && rc.motherboard['added'] < 1 && rc.case['added'] > 0:
			return false
		
		rc.get(cc)['added'] += 1
		
		## set as completed if required satisfied ##
		if (rc.get(cc)['added'] >= rc.get(cc)['required']):
			rc.get(cc)['completed'] = true
	else:
		#TODO: make in-game notification
		emit_signal("component_max_reached")
		print("ERROR!: This build already has the max ",cc," components")
		return false
	
	## ACTUALLY ADD COMPONENTS ##
	var component = Inventory.get_item(item_data)
	if cc=='case':
		Utils.change_parent(component, case_slot)
	else:
		var components = case_slot.get_children()
		for c in components:
			if !c.install_component(component):
				#TODO: make in-game notification
				print('ERROR occurred while trying to install ', cc)
				return false
	#TODO: make in-game notification
	Inventory.emit_signal("removed_item",component)
	
	print(cc,' installed successfully!')
	status_view.update_pc_status(self)
	return true


## TODO! IMPLEMENT UNINSTALL CONPONENTS AND ADD BACK IN INVENTORY ##
func remove_component(component_key: String) -> bool:
	var ckey = component_key
	if rc.get(ckey)['added'] <= 0: return false
	
	rc.get(ckey)['added'] -= 1
	if rc.get(ckey)['added'] < rc.get(ckey)['required']:
		rc.get(ckey)['completed'] = false
	
	status_view.update_status(self)
	return true


func is_completed(exclude_cover = true):
	for k in rc.keys():
		if !rc[k]['completed']:
			if exclude_cover && k=='case_cover': continue
			else: return false
	print(build_data.category,' completed')
	return true
