class_name BuildRequest extends Node

enum RequestClass {
	Undefined,
	Gaming_AAA,
	Gaming_VR,
	Gaming_Indie,
	VideoEditing,
	Modeling,
	Writing,
}
var request_class = RequestClass.Undefined setget setRequiredComponents, get_request_class
var id setget ,getId
var client
var description

var default_specs = { 'cpu':{},'motherboard':{},'memory':{},'case':{},'storage':{},'cooler':{},'psu':{} }
var specs = default_specs


func setRequiredComponents(value):
	request_class = value
	
	match request_class:
		RequestClass.Undefined:
			specs = default_specs
		RequestClass.Gaming_AAA:
			pass
		RequestClass.VideoEditing:
			specs['cpu'].cores = 8
			specs['memory'].size = 16
			specs['storage'].size = 1000


func get_request_class():
	return RequestClass.keys()[request_class]

func getId():
	if !id: id = Utils.generate_id()
	return id
