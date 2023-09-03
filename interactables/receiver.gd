class_name Receiver extends Interactable

export (PackedScene) var starter_pckg

onready var pckg_models := $pckg_models
onready var pckgs_gui := $ReceiverUI


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")
	if starter_pckg:
		var pckg = starter_pckg.instance()
		Events.emit_signal("new_package",pckg)


func spawn_pckg(pckg:ItemsPackage):
	pckg_models.add_child(pckg)
	pckgs_gui.add_package(pckg)


func __on_Event_new_package(pckg):
	spawn_pckg(pckg)


func _on_ReceivedPackages_pckg_removed(p):
	for pckg in pckg_models.get_children():
		if pckg == p: pckg.queue_free()
