class_name wComponentDetails extends Control

signal _pressed(_deal)

var item_linked: Dictionary setget setValues
var is_new := true setget setIsNew
var price := 0.00 setget setPrice
var description setget setDescription
var posted_date setget setPostedDate
var icon setget setIcon


func setValues(value):
	item_linked = value
	$HBoxContainer/link.text = str(item_linked.name_)
	self.is_new = true
	self.price = 0.00
#	self.icon = item_linked.icon_
	self.description = item_linked.name_
	self.posted_date = 'now'


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
