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
var request_class = RequestClass.Undefined setget setRequiredComponents
var current_build = {}
var r_description
var client
var required_components = {} 
var category

func setRequiredComponents(value):
	request_class = value
	
	match request_class:
		RequestClass.Undefined:
			required_components.cpu.min = 1
#			var min_cpu = 1
#			var min_ram = 1
#			var min_storage = 80
#			var min_gpu = 0
			pass
		RequestClass.Gaming_AAA:
			pass
		RequestClass.VideoEditing:
#			var min_cpu_cores = 8
#			var min_ram_mem = 16
#			var min_storage = 1000
#			var min_gpu = 1
			
#			var b_ram = current_build.components.ram.memory
#			if b_ram >= r_ram_mem
			pass
