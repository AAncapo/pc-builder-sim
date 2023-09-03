extends Control

onready var interaction_menus = $InteractablesUI


func _ready():
	Events.connect("interaction_started",self,"_on_interaction_started")
	Events.connect("interaction_ended",self,"_on_interaction_ended")


func _on_interaction_started(obj:Interactable):
	obj.enter()

func _on_interaction_ended():
	$InteractablesUI.current_tab = 0
