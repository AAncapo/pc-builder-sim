extends MeshInstance

var bStatus = preload("res://interactables/buildb/bstatus_label.tscn")

func _ready():
	set_as_toplevel(true)


func update_pc_status(build:Build):
	var required_list := $"%r_list"
	for r in required_list.get_children():
		r.queue_free()
	
	$"%name".text = str(build.category.capitalize(),': ',build.name_.capitalize())
	for key in build.rc:
		var bstatus_label = bStatus.instance()
		var _pressed = build.rc[key]['completed']
		var _max = build.rc[key]['max']
		var _added = build.rc[key]['added']
		bstatus_label.component_key_linked = key
		bstatus_label.update_values(str(key), _pressed, _added, _max)
		
		required_list.add_child(bstatus_label)
			
#			if bstatus_label.is_connected("uninstall", self,"_on_rc_uninstall_pressed"): return
#			bstatus_label.connect("uninstall", self, "_on_rc_uninstall_pressed")
