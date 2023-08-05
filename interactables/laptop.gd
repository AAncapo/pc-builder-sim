class_name Laptop extends Interactable

onready var interaction_pos = $cam_interaction_point
onready var web := $www

func _ready():
	web.hide()


func interact():
	web.show()


func exit():
	web.hide()
	web.componentStore.buy_items()
