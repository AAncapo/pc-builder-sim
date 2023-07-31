extends Button

signal _pressed(bp)
#signal _hover(item)

var bp_linked: BuildProject

func _ready():
	text = bp_linked.project_name


func _on_bp_button_pressed():
	emit_signal("_pressed",bp_linked)


func _on_bp_button_mouse_entered():
#	emit_signal("_hover", bp_linked)
	pass
