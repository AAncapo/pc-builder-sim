class_name Receiver extends Interactable

onready var pckg_models := $pckg_models
onready var pckgs_gui := $pckgs_gui


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")


func spawn_pckg(pckg:PackedScene):
	var new_pckg = pckg.instance()
	## instance package model in 3D world as visual representation ##
	pckg_models.add_child(new_pckg)
	## update gui pckg lists ##
	pckgs_gui.add_package(new_pckg)


func __on_Event_new_package(pckg):
	spawn_pckg(pckg)


func interact():
	pckgs_gui.show()
func exit():
	pckgs_gui.hide()
