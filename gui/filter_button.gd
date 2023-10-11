class_name FilterButton extends Button

signal _pressed(button)

export (bool) var mod_size = false
onready var init_size = rect_min_size


func _ready():
	toggle_mode = true


func _on_filter_button_gui_input(event):
	if event is InputEventMouseButton && event.pressed:
		if pressed:
			accept_event()

func _on_filter_button_pressed():
	emit_signal("_pressed",self)

func _on_filter_button_toggled(button_pressed):
	if mod_size:
		var t = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		t.tween_property(self,'rect_min_size',(rect_min_size * 0.8) if !button_pressed else init_size, 0.2)
