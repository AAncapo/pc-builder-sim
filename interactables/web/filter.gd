class_name Filter extends HBoxContainer

signal filtered_by(tag, show_all)

func _ready():
	var filters = get_children()
	for f in filters:
		f.connect("_pressed",self,"_on_filter")

func _on_filter(button):
	var show_all = false
	if button.name.to_lower() == 'all':
		show_all = true
	emit_signal("filtered_by",button.name.to_lower(),show_all)
