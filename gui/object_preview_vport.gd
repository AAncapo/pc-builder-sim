extends ViewportContainer

onready var item_holder := $Viewport/Camera/items
onready var meshInstance := $Viewport/Camera/items/MeshInstance
#var displayed_item: Item


func display_item(item_mesh):
	meshInstance.mesh = item_mesh
