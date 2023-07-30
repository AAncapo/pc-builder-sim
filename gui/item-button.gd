class_name iButton extends Button

signal _pressed(button)
signal _hover(item)

var item_linked: Item

func _ready():
	text = item_linked.nametag


func _on_itembutton_pressed():
	emit_signal("_pressed",self)


func _on_item_button_mouse_entered():
	emit_signal("_hover", item_linked)
