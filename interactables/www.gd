extends Control

onready var on_sale_container = $"%on_sale"
var itemPool = preload("res://item/ItemPool.tres")
var offer_detail = preload("res://interactables/web/www_component_detail.tscn")
var package_template = preload("res://packages/package.tscn")
var item_chart = []


func _ready():
	for _x_ in range(10):
		generate_item_offer()


func generate_item_offer():
	var path = str("res://components/custom_components/",itemPool.all_items[randi()%itemPool.all_items.size()])
	var item_ps = load(path)
	var item = item_ps.instance()
	$"%itemsOnSale".add_child(item)
	var desc = str(item.item_class,' warever')
	
	var offer:wwwComponentDetails = offer_detail.instance()
	offer.set_values(item, true, 0.00, desc)
	offer.connect("_pressed",self,"_on_offer_pressed")
	on_sale_container.add_child(offer)


func _on_offer_pressed(offer:wwwComponentDetails):
	add_to_chart(offer)


func add_to_chart(offer):
	item_chart.append(offer)


func buy_items():
	var items = []
	for o in item_chart:
		items.append(o.item_linked)
	print(items)
	send_package(items)


func send_package(items:Array):
	var new_pckg: ItemsPackage = package_template.instance()
	new_pckg.create_new_package('www items','revolico',items)
	Events.emit_signal("new_package",new_pckg)
