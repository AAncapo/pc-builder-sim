class_name wwwComponentDetails extends Control

signal _pressed(_offer)

var item_linked: Item
var is_new := true setget setIsNew
var price := 0.00 setget setPrice
var description setget setDescription
var posted_date setget setPostedDate


func set_values(item:Item,_new:bool, _price:float, desc:String, date = 'now'):
	item_linked = item
	self.is_new = _new
	self.price = _price
	self.description = desc
	self.posted_date = date


func setIsNew(value):
	is_new = value
	$HBoxContainer/new.visible = is_new

func setPrice(value):
	price = value
	$HBoxContainer/price.text = str('$ ',price)

func setDescription(value):
	description = value
	$HBoxContainer/link.text = str(description)

func setPostedDate(value):
	posted_date = value


func _on_link_pressed():
	emit_signal("_pressed",self)
