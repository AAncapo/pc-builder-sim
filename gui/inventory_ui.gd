extends Control

signal item_button_pressed(button)
export (String) var exclusive_for
export (String) var exclude
onready var itemContainer = $"%ItemContainer"
onready var header = $VBoxContainer/Label

func _ready():
	Inventory.connect("added_item",self,"_on_item_added")
	Inventory.connect("removed_item",self,"_on_item_removed")
	Events.connect("cmp_installed",self,"_on_cmp_installed")
	Events.connect("cmp_uninstalled",self,"_on_cmp_uninstalled")


func _on_item_added(new_item:Dictionary):
	var button:LinkedButton = itemContainer.add_item(new_item)
	button.connect("_pressed",self,"_on_button_pressed")
	if (exclusive_for && new_item.class_ != exclusive_for) || (exclude && new_item.class_ == exclude):
		button.hide()


func _on_item_removed(id:String):
	for b in itemContainer.get_items():
		if b.item_linked.id == id:
			b.queue_free()
			return


func display(filtr_class_=null,_header=null):
#	if _header: header.text = _header
	show()
	if exclusive_for:
		for i in itemContainer.get_items():
			i.visible = i.item_linked.class_ == exclusive_for
		itemContainer.get_visible_items()
		return
	
	if filtr_class_:
		#Apply filter based in cmp.slots to display only installable cmp#
		var display = false
		for i in itemContainer.get_items():
				i.visible = i.item_linked.class_ == filtr_class_
				if i.visible && !display: display = true
		itemContainer.get_visible_items()


func _on_button_pressed(button:LinkedButton):
	emit_signal("item_button_pressed",button)
	if !exclusive_for: hide()


func _on_cmp_installed(cdata:Dictionary):
	if exclusive_for: return
	for b in itemContainer.get_items():
		if b.item_linked.id == cdata.id:
			#TODO: apply installed effect in button
			b.toggle = true

func _on_cmp_uninstalled(cdata:Dictionary):
	if exclusive_for: return
	for b in itemContainer.get_items():
		if b.item_linked.id == cdata.id:
			#TODO: apply uninstalled effect in button
			b.toggle = false
