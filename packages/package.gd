class_name Package extends MeshInstance

onready var item_template = preload("res://components/component.tscn")
onready var items = $items

func _ready():
	fill_package_w_random_items()


func fill_package_w_random_items():
	var amount = randi()%5
	for i in range(amount):
		var new_item = item_template.instance()
		items.add_child(new_item)
