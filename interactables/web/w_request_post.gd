class_name wRequestPost extends Control

signal _pressed(post)

var _client: wClient
var description
var profile_img
var brequest: BuildRequest

func set_values(rb:BuildRequest, a:wClient, desc:String, pfp=null):
	brequest = rb
	_client = a
	description = desc
	profile_img = pfp
	
	$link.text = str(_client.id,'  -  ',description)
	$link.icon = profile_img


func _on_link_pressed():
	emit_signal("_pressed",self)
