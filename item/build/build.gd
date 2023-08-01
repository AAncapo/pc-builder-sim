class_name Build extends Item

signal component_not_supported
signal component_max_reached

onready var bBase := $base
var category  ## personal/requested

var rc: Dictionary = {
	'case': { 'required':1,'added':0,'max':1,'completed':false },
	'motherboard': { 'required':1,'added':0,'max':1,'completed':false},
	'ram': { 'required':1,'added':0,'max':1,'completed':false },
	'cpu': { 'required':1,'added':0,'max':1,'completed':false },
	'cpu_fan': {'required':1,'added':0,'max':1,'completed':false },
	'hdd': { 'required':1,'added':0,'max':1,'completed':false },
	'psu': { 'required':1,'added':0,'max':1,'completed':false },
}


func add_component(new_component:Component) -> bool:
	var cc = new_component.item_class
	if !rc.has(cc):
		#TODO: make in-game notification
		emit_signal("component_not_supported")
		print("ERROR!: This build do not REQUIRE or SUPPORT this component: ",cc,".")
		return false
	## check-add if hasnt reached max ##
	if (rc.get(cc)['added'] < rc.get(cc)['max']):
		
		## set HDD/RAM max ##
		if cc == 'case':
			rc.get('hdd')['max'] = new_component.hdd_slots
		if cc == 'motherboard':
			rc.get('ram')['max'] = new_component.ram_slots
		
		## REJECT component if case/mboard havent been added ##
		if cc!='case' && rc['case']['added'] < 1:
			return false
		if cc!='motherboard' && rc['motherboard']['added'] < 1 && rc['case']['added'] > 0:
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
	if cc=='case':
		Utils.change_parent_to(new_component, bBase)
	else:
		var components = bBase.get_children()
		for c in components:
			if !c.install_component(new_component):
				#TODO: make in-game notification
				print('ERROR occurred while trying to install ', cc)
				return false
	#TODO: make in-game notification
	Events.emit_signal("removed_item_from_inv",new_component)
	print(cc,' installed successfully!')
	return true


## TODO! IMPLEMENT UNINSTALL CONPONENTS AND ADD BACK IN INVENTORY ##
func remove_component(component_key: String) -> bool:
	var ckey = component_key
	if rc.get(ckey)['added'] <= 0:
		return false
	
	
	rc.get(ckey)['added'] -= 1
	if rc.get(ckey)['added'] < rc.get(ckey)['required']:
		rc.get(ckey)['completed'] = false
	
	return true
