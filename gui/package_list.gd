extends Control

var pckg_items_temp = preload("res://gui/pckg_items.tscn")
var button_temp = preload("res://gui/item_button.tscn")

onready var obj_preview_vp = $"object_preview_3D"
var packages = []
var current_pckg: ItemsPackage


func add_package(new_pckg:ItemsPackage):
	packages.append(new_pckg)
	create_item_list(new_pckg)
	if !current_pckg:
		current_pckg = new_pckg


func create_item_list(_pckg:ItemsPackage):
	## add new package tab ##
	var new_item_list = pckg_items_temp.instance()
	$"%packages_list".add_child(new_item_list)
	new_item_list.name = _pckg.sender
	
	## instance buttons x items in pckg ##
	var pckg_items = _pckg.get_items()
	for item in pckg_items:
		var ibutton: Button = button_temp.instance()
		ibutton.item = item
		new_item_list.add_child(ibutton)
		
		ibutton.connect("_pressed", self, "__on_ibutton_pressed")


func __on_ibutton_pressed(b_item:Item):
	var item_mesh = b_item.get_child(0).mesh.duplicate()
	obj_preview_vp.display_item(item_mesh)


func _on_packages_list_tab_changed(tab):
	current_pckg = packages[tab]
#	obj_preview_vp.update_items_to_display(current_pckg.get_items())


func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
