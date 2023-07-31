class_name Item extends Spatial

var item_id
#var pckg_origin: ItemsPackage

func _ready():
	item_id = Utils.generate_id(10)

func get_mesh():
	pass
