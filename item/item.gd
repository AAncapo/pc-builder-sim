class_name Item extends Spatial

var id_
var name_
export(StreamTexture)var icon_

func _ready():
	id_ = Utils.generate_id(10)

func get_mesh():
	pass
