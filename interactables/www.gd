extends Control
## www ##

onready var requestForum := $TabContainer/RequestForum
onready var componentStore := $TabContainer/ComponentStore
var pckg_tscn = preload("res://packages/package.tscn")


func _ready():
	Events.connect("request_accepted",self,"_on_request_accepted")
	
	for k in Market.world_items.keys():
		var item = Market.get_item(k)
		componentStore.generate_item_deal(item)

func _on_request_accepted(req):
	var pckg:ItemsPackage = pckg_tscn.instance()
	pckg.create_new_package(req.client.name_,[req.client.build])
	Events.emit_signal("new_package",pckg)
