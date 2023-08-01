extends HBoxContainer
## Build component status label ##

signal uninstall(linked)

var component_key_linked: String

func update_values(_component_name,_check,_added,_max):
	$installed.text = 'installed' if _check else 'not found'
	$component_name.text = _component_name
	$added_max.text = str(_added,'/',_max)


func _on_uninstall_pressed():
	emit_signal("uninstall", component_key_linked)
