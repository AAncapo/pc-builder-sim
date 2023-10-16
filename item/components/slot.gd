class_name ComponentSlot extends Area


onready var vis_pos := $Position3D

func _on_slot_area_entered(area):
	var class_ = get_parent().name
	var p = area.owner
	if p is Player && p.equipped && class_==str("s-",p.equipped.data.class):
		p.equipped.placeholder_v.global_transform = vis_pos.global_transform
		vis_pos.show()

func _on_slot_area_exited(area):
	vis_pos.hide()
