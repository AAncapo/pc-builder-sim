extends Control
## BuildRequests ##

var rb_button_template = preload("res://interactables/buildb/bb_rb_button.tscn")
var brequests = []


func _ready():
	Events.connect("request_accepted", self, "_on_request_accepted")


func add_new_request_button(req_post):
	var new_rbbutton: RBuildButton = rb_button_template.instance()
	new_rbbutton.post_linked = req_post
	
	$"%rb_list".add_child(new_rbbutton)
	new_rbbutton.connect("send_pressed", self, "_on_request_completed")


func _on_request_accepted(post:wRequestPost):
	add_new_request_button(post)

func _on_request_completed(post):
	Events.emit_signal("request_completed",post)
