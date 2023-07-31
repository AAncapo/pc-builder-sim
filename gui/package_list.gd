extends Control

onready var obj_preview_vp = $"%object_preview_3D"
var button_container_temp = preload("res://gui/item_buttons_container.tscn")
var button_temp = preload("res://gui/item_button.tscn")

func _ready():
	hide()


func add_package(new_pckg:ItemsPackage):
	## add new package tab ##
	var itemlist = button_container_temp.instance()
	$"%packages_list".add_child(itemlist)
	itemlist.name = new_pckg.sender
	
	## instance buttons x items in pckg ##
	var pckg_items = new_pckg.pckg_items
	for item in pckg_items:
		var button: iButton = button_temp.instance()
		button.item_linked = item
		itemlist.add_items(button)
		button.connect("hover", self, "_on_item_button_hover")
		button.connect("stop_hover",self,"_on_item_button_stop_hover")
		button.connect("_pressed", self, "_on_item_button_pressed")


func _on_item_button_hover(_item:Item):
	var item_mesh = _item.get_mesh()
	if item_mesh:
		obj_preview_vp.display_item(item_mesh)


func _on_item_button_stop_hover():
	obj_preview_vp.display_item(null)


func _on_item_button_pressed(_button:iButton):
	Events.emit_signal("added_item_to_inv", _button.item_linked)
	_button.queue_free()


func _on_take_all_pressed():
	var pckg_list := $"%packages_list"
	var item_list = pckg_list.get_child(pckg_list.current_tab).get_items()
	for button in item_list:
		Events.emit_signal("added_item_to_inv",button.item_linked)
		button.queue_free()
	
	yield(get_tree().create_timer(0.2),"timeout")
	if item_list.size() <= 0:
		pckg_list.get_child(pckg_list.current_tab).queue_free()


func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
