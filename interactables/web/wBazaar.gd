extends Control

onready var postContainer = $site/ScrollContainer/body/PostContainer
onready var dialogWindow = $"%AcceptDialog"
onready var item_container = dialogWindow.get_node("ItemContainer")
var selected_items = []


func _on_create_post_pressed():
	item_container.remove_items()
	for i in Inventory.items:
		var button = item_container.add_item(i.data)
		button.connect("_pressed",self,"_on_item_selected")
	dialogWindow.popup()


func _on_item_selected(button:LinkedButton):
	if selected_items.has(button.item_linked):
		selected_items.remove(selected_items.find(button.item_linked))
		return
	selected_items.append(button.item_linked)


func _on_AcceptDialog_confirmed():
	if !selected_items.empty():
		for i in selected_items:
			add_post(i)
			# remove item from inventory #
			Inventory.remove_item(i)
			Events.emit_signal("item_uploaded",i)
			selected_items.clear()


func add_post(item):
	var post = postContainer.add_item(item)
	post.display_mode = 1
