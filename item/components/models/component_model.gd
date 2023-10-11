extends Spatial

const COLOR_BASE = Color(1,1,1,0)
const COLOR_ACTIVE = Color(1,1,1,0.05)
var component
var mesh:MeshInstance


func __init(cmp):
	component = cmp
	mesh = get_child(0)
	mesh.create_trimesh_collision()
#	var sb:StaticBody = mesh.get_child(0)
#	sb.connect("input_event",self,"_on_input_event")
#	sb.connect("mouse_entered",self,"_on_mouse_enter")
#	sb.connect("mouse_exited",self,"_on_mouse_exit")
	
	var overlay = SpatialMaterial.new()
	overlay.flags_transparent = true
	mesh.material_overlay = overlay
	mesh.material_overlay.albedo_color = COLOR_BASE


func _on_input_event(_cam, ev, _pos, _normal, _shape_idx):
	if ev is InputEventMouseButton && ev.pressed:
		if ev.button_index == 1:
			Events.emit_signal("cmp_mouse_selected",component)

func _on_mouse_enter():
	mesh.material_overlay.albedo_color = COLOR_ACTIVE

func _on_mouse_exit():
	mesh.material_overlay.albedo_color = COLOR_BASE
