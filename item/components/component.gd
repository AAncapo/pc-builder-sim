class_name Component extends Item

var power_comsumption: int
var component_class: String
var parent_cclass: String


func install_component(component:Component):
	var slots = []
	if data.item_class=='case' && component.data.parent_class == 'motherboard':
		var mboardSlot = $slots.get_node_or_null("s-motherboard")
		if mboardSlot: 
			return mboardSlot.get_child(0).install_component(component)
	slots = $slots.get_children()
	# if have any slot
	if !slots.empty():
		for s in slots:
			if s.name == str('s-',component.data.item_class):
				# if slot have subslots
				if s.get_child_count() > 0:
					for ss in s.get_children():
						# if subslot is free
						if ss.get_child_count() == 0:
							## install component in sub_slot
							Utils.change_parent(component,ss)
							return true
				else:
					## install component in unique slot #3
					Utils.change_parent(component,s)
					return true


func get_mesh():
	if $visual.get_child_count() > 0:
		return $visual.get_child(0).get_child(0).mesh
