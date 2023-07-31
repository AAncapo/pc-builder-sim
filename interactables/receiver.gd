class_name Receiver extends Interactable

export (PackedScene) var starter_pckg
onready var pckg_models := $pckg_models
onready var pckgs_gui := $pckgs_gui


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")
	if starter_pckg:
		var pckg = starter_pckg.instance()
		Events.emit_signal("new_package",pckg) # tells RECEIVER that there is a new pckg


func spawn_pckg(pckg:ItemsPackage):
	## instance package model in 3D world as visual representation ##
	pckg_models.add_child(pckg)
	## update gui pckg lists ##
	pckgs_gui.add_package(pckg)


func __on_Event_new_package(pckg):
	spawn_pckg(pckg)


func interact():
	pckgs_gui.show()
func exit():
	pckgs_gui.hide()
