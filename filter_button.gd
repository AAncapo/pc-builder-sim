extends Button

signal _pressed(button)

func _on_filter_button_pressed():
	emit_signal("_pressed",self)
