class_name Receiver extends Interactable

onready var packages := $packages
onready var gui_received_pckgs := $received_pckgs


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")


func __on_Event_new_package(pckg):
	spawn_pckg(pckg)

func interact():
	gui_received_pckgs.show()
func exit():
	gui_received_pckgs.hide()


func spawn_pckg(pckg:PackedScene):
	var new_pckg = pckg.instance()
	## instance package model in world as visual representation ##
	packages.add_child(new_pckg)
	
	## update gui pckg lists ##
	gui_received_pckgs.add_package(new_pckg)
