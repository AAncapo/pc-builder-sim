class_name Inventory extends Control

onready var allItems := $"%All"
var items_stored = []
var button_temp = preload("res://gui/item_button.tscn")


func _ready():
	hide()
	Events.connect("added_item_to_inv",self,"__on_item_added")


func __on_item_added(new_item):
	var ibutton:iButton = button_temp.instance()
	ibutton.item_linked = new_item
	allItems.add_child(ibutton)
	items_stored.append(new_item)
