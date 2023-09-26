extends Control
## Request Forum ##

var reqPost = preload("res://interactables/web/request_post.tscn")

func _ready():
	Events.connect("new_client_request",self,"_on_new_client_request")


func _on_new_client_request(req:Request):
	var req_post: RequestPost = reqPost.instance()
	req_post.request = req
	$"%posts".add_child(req_post)
	req_post.connect("_pressed",self,"_on_post_pressed")


func _on_post_pressed(req):
	Events.emit_signal("request_accepted",req)
