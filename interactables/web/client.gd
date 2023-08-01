class_name wClient extends Node

var id setget ,getClientId
var _name  #TODO: name generator
var profile_img: StreamTexture  #TODO: add profile images

func getClientId():
	if !id:
		id = Utils.generate_id(10)
	return id
