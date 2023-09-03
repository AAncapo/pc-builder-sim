class_name Build extends Component

var request
var added_components = []

func is_completed() -> bool:
	for rc in required_components:
		if !installed_components.has(rc):
			return false
	return true


## TODO! IMPLEMENT UNINSTALL CONPONENTS AND ADD BACK IN INVENTORY ##
func remove_component(component):
	pass
