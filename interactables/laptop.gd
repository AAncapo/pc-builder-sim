extends Interactable

onready var interaction_pos = $cam_interaction_point


func _ready():
	$www.hide()


func interact():
	$www.show()


func exit():
	$www.hide()
