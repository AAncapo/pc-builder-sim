class_name ComponentSlot extends Area


onready var meshInstance := $MeshInstance
var mesh:Mesh

func _on_slot_area_entered(area):
	var class_ = get_parent().name
	var p = area.owner
	if p is Player && p.equipped && class_==str("s-",p.equipped.data.class):
#		p.equipped.set_placeholder_mesh(meshInstance)
#		meshInstance.show()
		pass

func _on_slot_area_exited(area):
	meshInstance.hide()
