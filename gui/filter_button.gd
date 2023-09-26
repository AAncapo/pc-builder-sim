class_name FilterButton extends Button

signal _pressed(button)

func _ready():
	toggle_mode = true

func _on_filter_button_gui_input(event):
	if event is InputEventMouseButton && event.pressed:
		if pressed:
			accept_event()

func _on_filter_button_pressed():
	emit_signal("_pressed",self)
