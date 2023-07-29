extends Control

onready var item_list_temp = preload("res://gui/item_list.tscn")
onready var item_button_temp = preload("res://gui/item-button.tscn")
var packages: Array
#var cur_display_pckg: Package


func add_package(new_pckg):
	packages.append(new_pckg)
	create_item_list(new_pckg)


func create_item_list(_pckg:Package):
	var new_item_list = item_list_temp.instance()
	$"%packages_tabs".add_child(new_item_list)
	new_item_list.name = _pckg.sender
	
	var iButton_container = new_item_list.get_child(0)
	
	for i in _pckg.get_items():
		var iButton = item_button_temp.instance()
		iButton.item = i
		iButton_container.add_child(iButton)


func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
