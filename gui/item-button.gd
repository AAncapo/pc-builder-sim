class_name iButton extends Button

signal _pressed(button)
signal hover(item)
signal stop_hover

var item_linked: Item


func _ready():
	text = item_linked.item_class


func _on_item_button_pressed():
	emit_signal("_pressed",self)

func _on_item_button_mouse_entered():
	emit_signal("hover", item_linked)

func _on_item_button_mouse_exited():
	emit_signal("stop_hover")
