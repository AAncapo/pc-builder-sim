class_name Interactable extends StaticBody

export (NodePath) var interactionPoint
onready var interaction_point = get_node_or_null(interactionPoint)
export (NodePath) var uiControl
onready var ui = get_node_or_null(uiControl)

func _ready():
	Events.connect("interact",self,"_on_interact")


func enter():
	ui.show()
	Events.emit_signal("init_interaction",self)

func exit():
	ui.hide()

func _on_interact(tag):
	enter() if self.name.to_lower() == tag else exit()
