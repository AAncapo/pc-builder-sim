class_name Receiver extends Interactable

onready var packages := $packages
onready var pckg_list := $package_list


func _ready():
	Events.connect("new_package", self, "__on_Event_new_package")


func __on_Event_new_package(pckg):
	spawn_pckg(pckg)


func interact():
	pckg_list.show()

func exit():
	pckg_list.hide()


func spawn_pckg(pckg):
	var new_pckg = pckg.instance()
	packages.add_child(new_pckg)
	
	pckg_list.add_package(new_pckg)
