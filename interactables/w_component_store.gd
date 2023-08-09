extends Control

onready var on_sale_container = $"%on_sale"
var deal_detail = preload("res://interactables/web/www_component_detail.tscn")
var package_template = preload("res://packages/package.tscn")
var items_on_sale = []
var item_chart = []


func generate_item_deal():
	var item = Market.get_item()
	
	var deal:wComponentDetails = deal_detail.instance()
	deal.set_values(item, true, 0.00)
	deal.connect("_pressed",self,"_on_deal_pressed")
	items_on_sale.append(item)
	on_sale_container.add_child(deal)


func _on_deal_pressed(deal:wComponentDetails):
	add_to_chart(deal)


func add_to_chart(deal):
	item_chart.append(deal)


func buy_items():
	var items = []
	for o in item_chart:
		items.append(o.item_linked)
	if !items.empty(): send_package(items)


func send_package(items:Array):
	var new_pckg: ItemsPackage = package_template.instance()
	new_pckg.create_new_package('www items','revolico',items)
	Events.emit_signal("new_package",new_pckg)
	
