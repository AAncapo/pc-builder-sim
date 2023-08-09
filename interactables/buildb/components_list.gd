extends Control

signal install_component(component)

onready var components := $"%comps_list"
var ibutton_temp = preload("res://gui/item_button.tscn")


func _ready():
	Events.connect("added_item_to_inv", self, "add_new_component")
	Events.connect("removed_item_from_inv", self, "_on_bp_item_installed")


func add_new_component(item:Dictionary, _override):
	if item.item_class != 'build':
		var new_button = ibutton_temp.instance()
		new_button.item_linked = item
		components.add_child(new_button)
		
		new_button.connect("_pressed", self, "__on_ibutton_pressed")


func _on_bp_item_installed(item):
	for button in components.get_children():
		if button.item_linked.id == item.data.id:
			button.queue_free()
	

func __on_ibutton_pressed(button):
	emit_signal("install_component",button.item_linked)
