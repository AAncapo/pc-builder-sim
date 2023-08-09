extends Control

signal install_component(component_data)

onready var allItems := $"%All"
var button_temp = preload("res://gui/item_button.tscn")


func _ready():
	Inventory.connect("added_item",self,"__on_item_added")
	Inventory.connect("removed_item",self,"__on_item_removed")


func __on_item_added(new_item, _override):
	var button = button_temp.instance()
	button.item_linked = new_item
	allItems.add_child(button)
	button.connect("_pressed",self,"__on_button_pressed")
	

func __on_button_pressed(button):
	emit_signal("install_component",button.item_linked)


func __on_item_removed(item):
	for b in allItems.get_children():
		if b.item_linked.id == item.data.id:
			b.queue_free()
			return
