class_name Component extends Item

enum ItemClass {
	CASE,
	MOTHERBOARD,
	CPU,
	CPU_FAN,
	RAM,
	HDD,
	PSU,
	NULL
}
export (ItemClass) var item_class setget ,get_item_class
export (ItemClass) var parent_class setget ,get_parent_class
export (String) var name_tag
var hdd_slots := 0 setget ,get_hdd_slots
var ram_slots := 0 setget ,get_ram_slots


func _ready():
#	match item_class:
#		ItemClass.CASE:
#			hdd_slots = $slots.get_node("s-hdd").get_child_count()
#		ItemClass.MOTHERBOARD:
#			ram_slots = $slots.get_node("s-ram").get_child_count()
	pass


func install_component(component:Component):
	var slots = []
	if self.item_class=='case' && component.parent_class == 'motherboard':
		var mboardSlot = $slots.get_node_or_null("s-motherboard")
		if mboardSlot: 
			return mboardSlot.get_child(0).install_component(component)
	slots = $slots.get_children()
	# if have any slot
	if !slots.empty():
		for s in slots:
			if s.name==str('s-',component.item_class):
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


func get_hdd_slots():
	return $slots.get_node("s-hdd").get_child_count() if item_class==ItemClass.CASE else 0

func get_ram_slots():
	return $slots.get_node("s-ram").get_child_count() if item_class==ItemClass.MOTHERBOARD else 0


func get_item_class():
	return ItemClass.keys()[item_class].to_lower()

func get_parent_class():
	return ItemClass.keys()[parent_class].to_lower()

func get_mesh():
	if $visual.get_child_count() > 0:
		return $visual.get_child(0).get_child(0).mesh
