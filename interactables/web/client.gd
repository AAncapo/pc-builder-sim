class_name wClient extends Node

var id setget ,getClientId
var name_  #TODO: name generator
var profile_img: StreamTexture  #TODO: add profile images

var build: Dictionary
var budget


func getClientId():
	if !id:
		id = Utils.generate_id(10)
	return id
