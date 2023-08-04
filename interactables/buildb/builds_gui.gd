extends Control

signal create_new_project(pj_name, br)
signal build_project_selected(bp)
signal uninstalled_component(component_key)

onready var bp_list := $"%bp_list"
var bButton = preload("res://interactables/buildb/bp_button.tscn")


func _ready():
	Events.connect("request_accepted", self, "_on_request_accepted")
	
	for fb in $"%filters".get_children():
		fb.connect("_pressed",self,"filter_list")


func _on_new_project_pressed():
	$"%ConfirmationDialog".popup()
	$"%LineEdit".grab_focus()


func _on_ConfirmationDialog_confirmed():
	#TODO: send mmore information packed about the project
	emit_signal("create_new_project",$"%LineEdit".text, null)

## wRequestPost send here the info about the request and creates a new build project automatically ##
func _on_request_accepted(br):
## when a request is accepted it should be the same process as when a personal project has its name confirmed
	emit_signal("create_new_project",br.client.id,br)


func add_project(project:Build):
	var bbutton = bButton.instance()
	bbutton.item_linked = project
	bbutton.filter_tag = project.category
	bp_list.add_child(bbutton)
	bbutton.connect("_pressed",self, "open_project")


func open_project(bbutton:LinkedButton):
	emit_signal("build_project_selected",bbutton.item_linked)


func remove_project_button(project):
	for b in $"%bp_list".get_children():
		if b.item_linked == project:
			b.queue_free()


func filter_list(fbutton):
	for fb in $"%filters".get_children():
		fb.pressed = fb == fbutton
	for bp in $"%bp_list".get_children():
		bp.visible = bp.filter_tag==fbutton.name.to_lower() || bp.filter_tag==fbutton.text.to_lower()if fbutton.name.to_lower()!='all' else true
