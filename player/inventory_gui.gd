extends Control

onready var inv = load("res://player/inventory.tres")
onready var allItems := $"%All"
var button_temp = preload("res://gui/item_button.tscn")


func _ready():
	Events.connect("added_item_to_inv",self,"__on_item_added")


func __on_item_added(new_item):
	var ibutton:iButton = button_temp.instance()
	ibutton.item_linked = new_item
	allItems.add_child(ibutton)
	inv.stored_items.append(new_item)
