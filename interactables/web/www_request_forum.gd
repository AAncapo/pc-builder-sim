extends Control
## Request Forum ##

var wReqPostT = preload("res://interactables/web/w_request_post.tscn")


func generate_new_request_post():
	var new_request_post: wRequestPost = wReqPostT.instance()
	var c = Market.get_client()
	c.generate_request()
	new_request_post.set_values(c)
	
	$"%posts".add_child(new_request_post)
	new_request_post.connect("_pressed",self,"_on_post_pressed")


func _on_post_pressed(post):
	Events.emit_signal("request_accepted",post)
