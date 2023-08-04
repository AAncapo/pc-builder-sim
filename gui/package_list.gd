extends Control

signal pckg_removed(p)
signal display_item(item_mesh)  #connect to 3D obj preview viewport

onready var pckg_tab_container := $"%TabContainer"
var buttonContainr = preload("res://gui/item_buttons_container.tscn")
var itemButton = preload("res://gui/item_button.tscn")
var current_pckg_tab setget ,get_current_pckg_tab 
func get_current_pckg_tab():
	return pckg_tab_container.get_current_tab_control()


func _ready():
	hide()


func add_package(new_pckg:ItemsPackage):
	## add new package tab ##
	var itemlist = buttonContainr.instance()
	itemlist.name = new_pckg.sender
	itemlist.items_owner = new_pckg
	pckg_tab_container.add_child(itemlist)
	
	## instance buttons x items in pckg ##
	var items = new_pckg.pckg_items
	for i in items:
		var button = itemButton.instance()
		button.item_linked = i
		itemlist.add_items(button)
		button.connect("_pressed", self, "_on_itemb_pressed")
#		button.connect("_mouse_enter",self,"_on_itemb_mouse_enter")
#		button.connect("_mouse_exit",self,"_on_itemb_mouse_exit")


func _on_itemb_mouse_enter(button):
	var item_mesh = button.item_linked.get_mesh()
	if item_mesh:
		emit_signal("display_item",item_mesh)

func _on_itemb_mouse_exit():
	emit_signal("display_item",null)


func _on_itemb_pressed(_button:LinkedButton):
	Events.emit_signal("added_item_to_inv", _button.item_linked)
	_button.queue_free()
	yield(get_tree().create_timer(0.1),"timeout")
	var _item_list = self.current_pckg_tab.get_items()
	if _item_list.empty():
		emit_signal("pckg_removed",self.current_pckg_tab.items_owner)
		self.current_pckg_tab.queue_free()


func _on_take_all_pressed():
	if self.current_pckg_tab:
		var _item_list = self.current_pckg_tab.get_items()
		for button in _item_list:
			_on_itemb_pressed(button)

func _on_exit_pressed():
	Events.emit_signal("interaction_exited")
