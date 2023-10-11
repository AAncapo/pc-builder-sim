class_name Component extends Item

signal mouse_selected

#onready var visual = get_node_or_null('visual')
var power_supply
var slots = []
var installed_components = []  #nodes
var model_scr = preload("res://item/components/models/component_model.gd")


func _ready():
#	if visual: 
#		var model = visual.get_child(0)
#		model.set_script(model_scr)
#		model.__init(self)
	Events.connect("cmp_uninstalled", self, "_on_cmp_uninstalled")


func _init_():
	if data.class_=='case' || data.class_=='build' || data.class_=='psu':
		return
	
	#if psu...
	var pb = data.parent_build
	if pb && pb.psu:
		power_supply = pb.psu
		power_supply.supply_left -= data.power_consumption


func install_component(cdata:Dictionary, pbuild):
	if cdata.installed: 
		Events.emit_signal("cmp_alrdy_installed",cdata)
		return false
	
	slots = $slots.get_children()
	for s in slots:
		if s.name == str('s-',cdata.class_):
			# if slot have subslots
			if s.get_child_count() > 0:
				for ss in s.get_children():
					# if subslot is free
					if ss.get_child_count() == 0:
						## install in sub_slot ##
						if add_component(cdata,ss,pbuild):
							return true
				Events.emit_signal("no_free_slot",cdata)
			else:
				## install in unique slot ##
				if add_component(cdata,s,pbuild):
					return true
	## this component hasnt any slot available for component ##
	for ic in installed_components:
		if ic.install_component(cdata,pbuild):
			return true


func add_component(cdata:Dictionary, parent:Node, pbuild):
	var component = Inventory.get_item_from_dict(cdata)
	if !component:
		var path = str("res://item/components/custom_components/starter_",cdata.class_,".tscn")
		component = load(path).instance()
		component.data = cdata
	
	cdata.installed = true
	Utils.change_parent(component,parent)
	installed_components.append(component)
	cdata.parent_build = pbuild
	cdata.parent_build[cdata.class_] = component
	Events.emit_signal("cmp_installed",cdata)
	return true


func get_slots_classes_() -> Dictionary:
	var _slots = {}
	slots = $slots.get_children()
	for s in slots:
		var n:String = s.name
		n.erase(0,2)  #remove the 's-' in the slot name
		var subslots = s.get_child_count()
		_slots[n] = subslots
	return _slots


func uninstall():
	if data.class_ != 'build':
		data.parent_build.uninstall_component(data)


func _on_cmp_uninstalled(cdata):
	for ic in installed_components:
		if ic.data.id == cdata.id:
			Utils.change_parent(ic, Inventory.item_nodes)
			installed_components.remove(installed_components.find(ic))
