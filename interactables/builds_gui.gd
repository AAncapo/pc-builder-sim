extends Control

signal create_new_project(pj_name, br)
signal build_project_selected(bp)
signal uninstalled_component(component_key)

onready var bp_list := $"%bp_list"
var bpb_temp = preload("res://interactables/buildb/rb_button.tscn")
var rc_detail_temp = preload("res://gui/bp_rc_detail.tscn")

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
func _on_request_accepted(br:BuildRequest):
## when a request is accepted it should be the same process as when a personal project has its name confirmed
	emit_signal("create_new_project",br.client.id,br)


func add_project(project:Build):
	var button = bpb_temp.instance()
	button.item_linked = project
	button.filter_tag = project.category
	bp_list.add_child(button)
	button.connect("_pressed",self, "open_project")


func open_project(bbutton:LinkedButton):
	emit_signal("build_project_selected",bbutton.item_linked)


## Build Details ##
func update_bp_details(bp:Build):
	var required_list := $"%required"
	for r in required_list.get_children():
		r.queue_free()
	
	$"%build_name".text = str(bp.name_)
	
	for key in bp.rc:
		var rc_detail = rc_detail_temp.instance()
		var _pressed = bp.rc[key]['completed']
		var _max = bp.rc[key]['max']
		var _added = bp.rc[key]['added']
		rc_detail.component_key_linked = key
		rc_detail.update_values(str(key), _pressed, _added, _max)
		
		required_list.add_child(rc_detail)
		
		if rc_detail.is_connected("uninstall", self,"_on_rc_uninstall_pressed"): return
		rc_detail.connect("uninstall", self, "_on_rc_uninstall_pressed")

func _on_rc_uninstall_pressed(component_key):
	emit_signal("uninstalled_component", component_key)


func filter_list(fbutton):
	for bp in $"%bp_list".get_children():
		bp.visible = bp.filter_tag==fbutton.name.to_lower() if fbutton.name.to_lower()!='all' else true
