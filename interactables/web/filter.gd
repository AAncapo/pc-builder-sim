class_name FilterContainer extends HBoxContainer

signal apply_filter(tag, show_all)
onready var filters = get_children()


func _ready():
	for f in filters:
		f.connect("_pressed",self,"_on_filter")


func _on_filter(button):
	for fbutton in filters:
		if fbutton != button: fbutton.pressed = false
	var show_all = false
	if button.name.to_lower() == 'all':
		show_all = true
	emit_signal("apply_filter",button.name.to_lower(),show_all)
