class_name Request extends Node

enum BuildType {
	Undefined,
	Gaming_AAA,
	Gaming_VR,
	Gaming_Indie,
	VideoEditing,
	Modeling,
	Writing,
}
enum RequestClass {
	BuildRequest,
	RepairRequest
}
var request_class = RequestClass.RepairRequest setget setReqClass, getReqClass
func setReqClass(value):
	request_class = value
func getReqClass():
	return RequestClass.keys()[request_class]
var build_type = BuildType.Undefined setget setBuildType, getBuildType
func setBuildType(value):
	build_type = value
	
	match build_type:
		BuildType.Undefined:
			specs = default_specs
		BuildType.Gaming_AAA:
			pass
		BuildType.VideoEditing:
			specs['cpu'].cores = 8
			specs['memory'].size = 16
			specs['storage'].size = 1000
func getBuildType():
	return BuildType.keys()[build_type]
var id
var client
var description
var default_specs = { 'cpu':{},'motherboard':{},'memory':{},'case':{},'storage':{},'cooler':{},'psu':{} }
var specs = default_specs


#func getId():
#	if !id: id = Utils.generate_id()
#	return id
