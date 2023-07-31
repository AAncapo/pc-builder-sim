extends Control
## Request Forum ##

var wReqPostT = preload("res://interactables/web/w_request_post.tscn")


func generate_new_request():
	var br = BuildRequest.new()
	br.client = wClient.new()
	br.r_description = 'Hi my name is Timmy, i want beeg pc to play minecraft!!!!'
	
	var new_brequest_post: wRequestPost = wReqPostT.instance()
	new_brequest_post.set_values(br, br.client, br.r_description)
	
	$"%posts".add_child(new_brequest_post)
	new_brequest_post.connect("_pressed",self,"_on_post_pressed")


func _on_post_pressed(post):
	Events.emit_signal("request_accepted",post)
