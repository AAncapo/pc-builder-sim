extends Control
## www ##

onready var requestForum := $TabContainer/wwwRequestForum
onready var componentStore := $TabContainer/wwwComponentStore


func _ready():
	requestForum.generate_new_request()
	
	for _x_ in range(30):
		componentStore.generate_item_offer()


func _on_close_pressed():
	Events.emit_signal("interaction_exited")
