class_name Item extends Spatial

var item_id

func _ready():
	item_id = generate_item_id(10)


func generate_item_id(max_id_length: int):
	randomize()
	var chars = "abcdefghijklmnopqrstuvwxyz0123456789"
	max_id_length = clamp(max_id_length,4,chars.length())
	var id := ""
	for ch in max_id_length:
		id += chars[randi()%chars.length()]
	
	return id
