class_name RBuildButton extends Button

signal send_pressed(post)

var post_linked: wRequestPost setget setValues


func setValues(value):
	post_linked = value
	
	$"%client_pfp".texture = post_linked.profile_img
	$"%client_name".text = post_linked._client.id   ##TODO: change to client_name when name generator implemented
	$"%desc".text = post_linked.description


func _on_send_pressed():
	emit_signal("send_pressed", post_linked)


func _on_rb_button_toggled(button_pressed):
	#TODO: toggle display more information on/off mouse_enter
	pass # Replace with function body.

func _on_rb_button_mouse_entered():
	#TODO: display more information
	pass # Replace with function body.

func _on_rb_button_mouse_exited():
	pass # Replace with function body.
