class_name Client extends Node

var id setget ,getClientId
var name_:String  #TODO: name generator
var profile_img: StreamTexture  #TODO: add profile images

var build: Dictionary
var budget:float
var request: BuildRequest
var posted_request:bool


func generate_request():
	request = BuildRequest.new()
	request.client = self
	request.request_class = request.RequestClass.VideoEditing
	request.description = str("Hi, i need a PC for ",request.get_request_class(),' my budget is $',budget,'.')
	
	Events.emit_signal("new_client_request", request)
	var rdb = load("res://request/RequestDatabase.tres")
	rdb.client_requests.append(request)
	posted_request = true


func getClientId():
	if !id: id = Utils.generate_id(10)
	return id
