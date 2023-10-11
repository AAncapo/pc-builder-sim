extends Control


func _unhandled_input(event):
	if event is InputEventKey && event.pressed && event.scancode == KEY_ESCAPE:
		visible = !visible


func _on_restart_pressed():
	get_tree().reload_current_scene()
