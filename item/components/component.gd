class_name Component extends Item


var slots = []
var class_: String
var specs = {}
var installed = false
var installed_components = []  #nodes
var required_components = {}


func _ready():
	Events.connect("component_uninstalled", self, "_on_component_uninstalled")


func install_component(cdata:Dictionary):
	slots = $slots.get_children()
	for s in slots:
		if s.name == str('s-',cdata.class_):
			# if slot have subslots
			if s.get_child_count() > 0:
				for ss in s.get_children():
					# if subslot is free
					if ss.get_child_count() == 0:
						## install in sub_slot ##
						if add_component(cdata,ss):
							return true
				Events.emit_signal("no_slot_available",cdata)
			else:
				## install in unique slot ##
				if add_component(cdata,s):
					return true
	## this component hasnt any slot available for component ##
	for ic in installed_components:
		if ic.install_component(cdata):
			return true


func add_component(cdata, parent):
	var component = Inventory.get_item_from_dict(cdata)
	if component.installed:
		Events.emit_signal("component_already_installed",cdata.name_)
		return false
	component.installed = true
	Utils.change_parent(component,parent)
	installed_components.append(component)
	Events.emit_signal("component_installed",cdata)
	return true


func get_mesh():
	if $visual.get_child_count() > 0:
		return $visual.get_child(0).get_child(0).mesh


func _on_component_uninstalled(cdata):
	for ic in installed_components:
		if ic.data.id == cdata.id:
			ic.queue_free()
			installed_components.remove(installed_components.find(ic))
