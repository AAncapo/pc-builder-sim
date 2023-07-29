extends Control

onready var item_button = load("res://gui/item-button.tscn")
var package: Package


func create_item_list():
	for b in $"%buttons".get_children():
		b.queue_free()
	
	for i in package.items.get_children():
		var button = item_button.instance()
		button.item = i
		$"%buttons".add_child(button)
	


func _on_exit_pressed():
	Events.emit_signal("exit_int")
