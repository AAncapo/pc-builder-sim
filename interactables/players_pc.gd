extends Interactable

onready var interaction_pos = $cam_interaction_point


func interact():
	$shop.show()


func exit():
	$shop.hide()


func _on_close_pressed():
	Events.emit_signal("interaction_exited")
