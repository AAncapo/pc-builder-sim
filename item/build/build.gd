class_name Build extends Component

var request
var added_components = [] setget initBuild  #dicts
func initBuild(value):
	added_components = value
	for c in added_components:
		install_component(c)

func _ready():
	if !data.added_components.empty(): self.added_components = data.added_components

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
