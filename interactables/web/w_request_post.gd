class_name wRequestPost extends Control

signal _pressed(req)

var request: BuildRequest

func set_values(req):
	request = req
	$link.text = str(request.client.name_,'  -  ',request.description)


func _on_link_pressed():
	emit_signal("_pressed",request)
	$link.disabled = true
