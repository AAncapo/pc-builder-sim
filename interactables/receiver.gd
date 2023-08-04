class_name Receiver extends Interactable

export (PackedScene) var starter_pckg

onready var pckg_models := $pckg_models
onready var pckgs_gui := $ReceivedPackages


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")
	if starter_pckg:
		var pckg = starter_pckg.instance()
		Events.emit_signal("new_package",pckg)


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


func _on_ReceivedPackages_pckg_removed(p):
	for pckg in pckg_models.get_children():
		if pckg == p: pckg.queue_free()
