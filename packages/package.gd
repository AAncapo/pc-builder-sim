class_name ItemsPackage extends MeshInstance

export (Array, PackedScene) var custom_items = []
export (String) var sender
export (String) var pckg_name
var pckg_items = []


func _ready():
	if !custom_items.empty():
		var items = []
		for ci in custom_items:
			var item = ci.instance()
			items.append(item)
		create_new_package(pckg_name,sender,items)


func create_new_package(_name:String,_from:String,_items: Array):
	pckg_name =_name
	sender = _from
	pckg_items = _items
