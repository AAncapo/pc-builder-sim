class_name wComponentDetails extends Control

signal _pressed(_deal)

var item_linked: Dictionary
var is_new := true setget setIsNew
var price := 0.00 setget setPrice
var description setget setDescription
var posted_date setget setPostedDate
var icon setget setIcon


func set_values(item_data:Dictionary,_new:bool, _price:float, date = 'now'):
	item_linked = item_data
	self.is_new = _new
	self.price = _price
#	self.icon = item_linked.icon_
	self.description = item_data.name_
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

func setIcon(value):
	icon = value
	$HBoxContainer/icon.texture = value

func _on_link_pressed():
	emit_signal("_pressed",self)
