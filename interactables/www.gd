extends Control
## www ##

onready var requestForum := $TabContainer/wwwRequestForum
onready var componentStore := $TabContainer/wwwComponentStore


func _ready():
	for i in range(5):
		requestForum.generate_new_request_post()
	
	for _x_ in range(30):
		componentStore.generate_item_deal()


func _on_close_pressed():
	Events.emit_signal("interaction_exited")
