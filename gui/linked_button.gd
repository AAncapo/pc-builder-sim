class_name LinkedButton extends Button

signal _pressed(button)
signal _mouse_enter(button)
signal _mouse_exit(button)

var filter_tag

var item_linked: Item setget set_values
func set_values(value):
	item_linked = value
	if item_linked is Build:
		$"%client_name".text = item_linked.name_


func _ready():
	connect("pressed", self, "_on_pressed")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_pressed():
	emit_signal("_pressed", self)
func _on_mouse_entered():
	emit_signal("_mouse_enter", self)
func _on_mouse_exited():
	emit_signal("_mouse_exit", self)
