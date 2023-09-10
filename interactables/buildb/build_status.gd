extends Control

signal _update(b)

onready var componentButtons := $"%cbuttons"
var current_build:Build


func _ready():
	for cb in componentButtons.get_children():
		cb.connect("uninstall_pressed",self,"_on_cb_uninstall_pressed")


func update_status(build:Build):
	for cb in componentButtons.get_children():
		cb.component_linked = null
	if !build:
		hide()
		return
	show()
	current_build = build
	var added_components = build.added_components
	if added_components:
		for ac in added_components:
			for cb in componentButtons.get_children():
				if cb.name == ac.class_:
					cb.component_linked = ac


func _on_cb_uninstall_pressed(component):
	current_build.uninstall_component(component)
	emit_signal("_update",current_build)
