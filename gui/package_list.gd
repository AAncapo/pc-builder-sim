extends Control

signal pckg_removed(p)

onready var pckg_tab_container := $"%TabContainer"
var buttonContainr = preload("res://gui/items_container.tscn")
var current_pckg_tab setget ,get_current_pckg_tab 
func get_current_pckg_tab():
	return pckg_tab_container.get_current_tab_control()


func _ready():
	hide()


func add_package(new_pckg:ItemsPackage):
	## add new package tab ##
	var itemlist:ItemContainer = buttonContainr.instance()
	itemlist.name = new_pckg.sender
	itemlist.items_owner = new_pckg
	pckg_tab_container.add_child(itemlist)
	
	## instance buttons x items in pckg ##
	var items = new_pckg.pckg_items
	for i in items:
		var button = itemlist.add_item(i)
#		itemlist.show_info = true
#		itemlist.infopanel_pos = 'right'
		button.connect("_pressed", self, "_on_itemb_pressed")


func _on_itemb_pressed(_button:LinkedButton):
	Inventory.add_item(_button.item_linked, false)
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


func _on_TabController_empty():
	#TODO: ?????
#	Events.emit_signal("stop_interaction")
	pass
