extends VBoxContainer

signal uninstall_pressed(component)

var component_linked setget set_values


func _ready():
	$HBoxContainer/component.text = name.capitalize()

 
func set_values(value):
	component_linked = value
	
	$HBoxContainer/component.disabled = component_linked == null
	$HBoxContainer/uninstall.visible = component_linked != null
	
	Utils.remove_all_children($specs)
	if component_linked:
		var clkeys = component_linked.specs.keys()
		for k in clkeys:
			var data_label = Label.new()
			data_label.clip_text = true
			data_label.text = str(k.capitalize(),': ',component_linked.specs[k])
			$specs.add_child(data_label)


func _on_component_pressed():
	$specs.visible = !$specs.visible


func _on_uninstall_pressed():
	emit_signal("uninstall_pressed",component_linked)
