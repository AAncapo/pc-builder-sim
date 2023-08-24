class_name wClient extends Node

var id setget ,getClientId
var name_:String  #TODO: name generator
var profile_img: StreamTexture  #TODO: add profile images

var build: Dictionary
var budget:float
var request: BuildRequest
var posted_request: bool

func getClientId():
	if !id:
		id = Utils.generate_id(10)
	return id


func generate_request():
	posted_request = true  #TODO: set back to false when request gets completed
	request = BuildRequest.new()
	request.id = Utils.generate_id()
	request.client = self
	request.request_class = request.RequestClass.VideoEditing
	request.description = str("Hi, i need a PC for ",request.get_request_class(),' my budget is $',budget,'.')
