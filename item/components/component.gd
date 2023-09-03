class_name Component extends Item


var slots = []
var class_: String
var specs = {}

var installed_components = []
var required_components = {}


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
						add_component(cdata,ss)
						return true
				Events.emit_signal("no_slot_available",cdata)
			else:
				## install in unique slot ##
				add_component(cdata,s)
				return true
	## this component hasnt any slot available for component ##
	for ic in installed_components:
		if ic.install_component(cdata):
			return true


func add_component(cdata, parent):
	var component = get_item_from_dict(cdata)
	parent.add_child(component)
	installed_components.append(component)
	Events.emit_signal("component_installed",cdata)


func get_item_from_dict(data:Dictionary) -> Item:
	var path = str("res://item/components/custom_components/starter_",data.class_,".tscn")
	var item = load(path).instance()
	return item


func get_mesh():
	if $visual.get_child_count() > 0:
		return $visual.get_child(0).get_child(0).mesh
