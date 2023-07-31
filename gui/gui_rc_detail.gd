extends HBoxContainer

signal uninstall(linked)

var component_key_linked: String

func update_values(_component_name,_check,_added,_max):
	$CheckBox.text = _component_name
	$CheckBox.pressed = _check
	$added.text = str(_added,'/',_max)


func _on_uninstall_pressed():
	emit_signal("uninstall", component_key_linked)
