class_name Client extends Node

var id #setget ,getClientId
var name_:String  #TODO: name generator
var profile_img: StreamTexture  #TODO: add profile images

var build: Dictionary
var budget:float
var request:Request
var posted_request:bool


func _ready():
#	generate_request()
	pass

func generate_request():
	request = Request.new()
	request.client = self
	request.request_class = request.RequestClass.RepairRequest
	#TODO: asignar build
	var b = BuildGenerator.generate_build(false)
	b.name_ = str(name_,"'s broken PC")
	build = b
	#TODO: asignar descripcion segun tipo de request
	request.description = str(request.request_class,' - Budget: ',budget)
	
	Events.emit_signal("new_client_request", request)
	var rdb = load("res://request/RequestDatabase.tres")
	rdb.client_requests.append(request)
	posted_request = true


func rate_request(req):
	#TODO: pay to player
	pass


#func getClientId():
#	if !id: id = Utils.generate_id(10)
#	return id
