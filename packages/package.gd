class_name ItemsPackage extends MeshInstance

export var starter_package = false
var pckg_items = []
var sender
var pckg_name


func _ready():
	if starter_package:
		create_new_package('starter package','tutorial',Market.generate_starter_pckg())


func create_new_package(_name:String,_from:String,_items: Array):
	pckg_name =_name
	sender = _from
	pckg_items = _items
