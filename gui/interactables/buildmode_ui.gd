extends Control

signal start_new_build
signal component_selected(cdict)
signal build_selected(bdict)

onready var binstalled := $"%b_installed_components"
onready var br_status := $"%request_status"


func _ready():
	Events.connect("component_installed",self,"_on_component_installed")
	Events.connect("component_uninstalled",self,"_on_component_uninstalled")
	Events.connect("no_slot_available",self,"_on_no_slot_available")
	Events.connect("component_already_installed",self,"_on_component_already_installed")


func _update(current_bp):
	binstalled.update_status(current_bp)
	br_status.update_br_status(current_bp)


func _on_new_project_pressed():
	emit_signal("start_new_build")


func _on_component_installed(cdata):
	update_notif_label(str(cdata.name_,' INSTALLED!'))
func _on_component_uninstalled(cdata):
	update_notif_label(str(cdata.name_,' UNINSTALLED!'))
func _on_no_slot_available(cdata):
	update_notif_label(str('No Slot Available for ',cdata.name_))
func _on_component_already_installed(cdata):
	update_notif_label(str(cdata.name_,' already installed!'))

func update_notif_label(new_text):
	var notif_lbl = $"%Label"
	notif_lbl.text = new_text
	notif_lbl.show()
	yield(get_tree().create_timer(3,true),"timeout")
	notif_lbl.hide()
