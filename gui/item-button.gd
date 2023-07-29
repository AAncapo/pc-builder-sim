extends Button

signal _pressed(item)


var item: Item
var item_id: String


func _ready():
	text = item.nametag
	item_id = item.item_id


func _on_itembutton_pressed():
	emit_signal("_pressed",item)
