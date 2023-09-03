extends Control

onready var componentButtons := $"%cbuttons"


func _ready():
	for cb in componentButtons.get_children():
		cb.connect("uninstall_pressed",self,"_on_cb_uninstall_pressed")


func update_status(current_bp:Build):
	for cb in componentButtons.get_children():
		cb.component_linked = null
	
	if !current_bp:
		return
	var added_components = current_bp.added_components
	
	if added_components:
		for ac in added_components:
			for cb in componentButtons.get_children():
				if cb.name == ac.class_:
					cb.component_linked = ac


func _on_cb_uninstall_pressed(component):
	#TODO
	pass
