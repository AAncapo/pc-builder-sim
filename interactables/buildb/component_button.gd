extends VBoxContainer

var component_linked setget set_values


func _ready():
	$component.text = name.capitalize()

 
func set_values(value):
	component_linked = value
	
	$component.disabled = component_linked == null
	
	Utils.remove_all_children($specs)
	var clkeys = component_linked.keys()
	for k in clkeys:
		var data_label = Label.new()
		data_label.clip_text = true
		data_label.text = str(k,': ',component_linked[k])
		$specs.add_child(data_label)


func _on_component_pressed():
	$specs.visible = !$specs.visible
