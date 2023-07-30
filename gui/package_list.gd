extends Control

var pckg_items_temp = preload("res://gui/pckg_items.tscn")
var button_temp = preload("res://gui/item_button.tscn")

onready var obj_preview_vp = $"object_preview_3D"
var packages = []


func _ready():
	hide()


func add_package(new_pckg:ItemsPackage):
	packages.append(new_pckg)
	create_item_list(new_pckg)


func create_item_list(_pckg:ItemsPackage):
	## add new package tab ##
	var new_item_list = pckg_items_temp.instance()
	$"%packages_list".add_child(new_item_list)
	new_item_list.name = _pckg.sender
	## instance buttons x items in pckg ##
	var pckg_items = _pckg.get_items()
	for item in pckg_items:
		var ibutton: iButton = button_temp.instance()
		ibutton.item_linked = item
		new_item_list.add_child(ibutton)
		ibutton.connect("_hover", self, "__on_ibutton__hover")
		ibutton.connect("_pressed", self, "__on_ibutton_pressed")


func __on_ibutton__hover(_item:Item):
	var item_mesh = _item.get_child(0).mesh.duplicate()
	obj_preview_vp.display_item(item_mesh)


func __on_ibutton_pressed(_button:iButton):
	## send to inventory 
	Events.emit_signal("added_item_to_inv", _button.item_linked)
	_button.queue_free()


func _on_take_all_pressed():
	var pckg_list: TabContainer = $"%packages_list"
	var current_pkg = pckg_list.get_child(pckg_list.current_tab)
	for ibutton in current_pkg.get_children():
		Events.emit_signal("added_item_to_inv",ibutton.item_linked)
		ibutton.queue_free()


func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
