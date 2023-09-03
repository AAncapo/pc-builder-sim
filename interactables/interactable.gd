class_name Interactable extends StaticBody

export (NodePath) var interactionPoint
onready var interaction_point = get_node_or_null(interactionPoint)
export (NodePath) var uiControl
onready var ui_control = get_node_or_null(uiControl)

func _ready():
	if !has_method('enter'):
		print('WARNING: interactable ',name,' does not have a "enter()" function')
	if !has_method('exit'):
		print('WARNING: interactable ',name,' does not have a "exit()" function')


func enter():
	ui_control.show()

func exit():
	ui_control.hide()
