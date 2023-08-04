extends ViewportContainer

#onready var item_holder := $Viewport/Camera/item_holder
onready var meshInstance := $Viewport/Camera/item_holder/MeshInstance


func _on_display_item(item_mesh):
	meshInstance.mesh = item_mesh
