extends Node


func generate_id(_length: int = 8):
	randomize()
	var chars = "abcdefghijklmnopqrstuvwxyz0123456789"
	var id_length = min(_length,chars.length())
	var id := ""
	for ch in id_length:
		id += chars[randi()%chars.length()]
	return id


func change_parent_to(_node:Node, new_parent: Node):
	var prev_parent := _node.get_parent()
	if prev_parent:
		prev_parent.remove_child(_node)
	new_parent.add_child(_node)
