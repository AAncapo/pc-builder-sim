extends Control

onready var pckgs_list := $"%packages_list"
onready var obj_preview_vp = $"%object_preview_3D"
var button_container_temp = preload("res://gui/item_buttons_container.tscn")
var button_temp = preload("res://gui/item_button.tscn")


func _ready():
	hide()


func add_package(new_pckg:ItemsPackage):
	## add new package tab ##
	var itemlist = button_container_temp.instance()
	pckgs_list.add_child(itemlist)
	itemlist.name = new_pckg.sender
	
	## instance buttons x items in pckg ##
	var items = new_pckg.pckg_items
	for i in items:
		var button: iButton = button_temp.instance()
		button.item_linked = i
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
	
	yield(get_tree().create_timer(0.1),"timeout")
	var current_item_list = pckgs_list.get_current_tab_control().get_items()
	if current_item_list.empty():
		pckgs_list.get_current_tab_control().queue_free()


func _on_take_all_pressed():
	var current_item_list = pckgs_list.get_current_tab_control().get_items()
	for button in current_item_list:
		_on_item_button_pressed(button)

func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
