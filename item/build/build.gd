class_name Build extends Component

var request
var added_components = []  #all components installed in build


func is_completed() -> bool:
	for rc in required_components:
		if !installed_components.has(rc):
			return false
	return true


func uninstall_component(cdata):
	for ac in added_components:
		if ac.id == cdata.id:
			# add back to inventory
			Inventory.add_item(ac,true)
			added_components.remove(added_components.find(ac))
			# remove from build
			Events.emit_signal("component_uninstalled",ac)
