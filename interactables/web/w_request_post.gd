class_name wRequestPost extends Control

signal _pressed(post)

var _client: wClient

func set_values(client:wClient):
	_client = client
	$link.text = str(client.name_,'  -  ',client.request.description)


func _on_link_pressed():
	emit_signal("_pressed",self)
	$link.disabled = true
