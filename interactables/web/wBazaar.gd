extends Control

onready var postContainer = $site/ScrollContainer/body/posts
onready var dialogWindow = $"%AcceptDialog"
#var items = preload("res://player/inventory.tres")
var itemButton = preload("res://gui/item_button.tscn")
var itemList = preload("res://gui/items_container.tscn")
var postDet = preload("res://interactables/web/www_component_detail.tscn")
var selected_item: Item


func _on_create_post_pressed():
	Utils.remove_all_children(dialogWindow.get_node("Container"))
	
	var item_list = itemList.instance()
	dialogWindow.get_node("Container").add_child(item_list)
	
	for i in Inventory.stored_items:
		var button: LinkedButton = itemButton.instance()
		button.item_linked = i
		item_list.add_items(button)
		button.connect("_pressed",self,"_on_item_selected")
	dialogWindow.popup()


func _on_item_selected(button:LinkedButton):
	selected_item = button.item_linked


func _on_AcceptDialog_confirmed():
	if selected_item:
		add_post(selected_item)
		
		# remove item from inventory #
		Events.emit_signal("removed_item_from_inv",selected_item)
		
		selected_item = null


func add_post(item):
	var post = postDet.instance()
	post.item_linked = item
	postContainer.add_child(post)
