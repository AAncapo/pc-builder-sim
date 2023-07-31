extends Node


func generate_id(max_id_length: int = 8):
	randomize()
	var chars = "abcdefghijklmnopqrstuvwxyz0123456789"
	max_id_length = max(4,chars.length())
	var id := ""
	for ch in max_id_length:
		id += chars[randi()%chars.length()]
	return id


func change_parent_to(_node:Node, new_parent: Node):
	var prev_parent := _node.get_parent()
	if prev_parent:
		prev_parent.remove_child(_node)
	new_parent.add_child(_node)