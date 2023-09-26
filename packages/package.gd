class_name ItemsPackage extends MeshInstance

export var starter_package = false
var pckg_items = []
var sender


func _ready():
	if starter_package:
		create_new_package('Starter Package',Market.generate_starter_pckg())


func create_new_package(_from:String,_items: Array):
	sender = _from
	pckg_items = _items
