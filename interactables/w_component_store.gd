extends Control

onready var on_sale_container = $"%on_sale"
var deal_detail = preload("res://interactables/web/www_component_detail.tscn")
var package_template = preload("res://packages/package.tscn")
#var items_on_sale = []
var item_chart = []


func generate_item_deal():
	var item = Market.get_item()
	
	var deal:wComponentDetails = deal_detail.instance()
	deal.item_linked = item
	deal.connect("_pressed",self,"_on_deal_pressed")
#	items_on_sale.append(item)
	on_sale_container.add_child(deal)


func _on_deal_pressed(deal:wComponentDetails):
	add_to_chart(deal)


func add_to_chart(deal):
	item_chart.append(deal)


func buy_items():
	var items = []
	for o in item_chart:
		items.append(o.item_linked)
		for ddetail in on_sale_container.get_children():
			if ddetail == o:
				ddetail.queue_free()
	if !items.empty(): send_package(items)
	item_chart.clear()


func send_package(items:Array):
	var new_pckg: ItemsPackage = package_template.instance()
	new_pckg.create_new_package('www items','Store',items)
	Events.emit_signal("new_package",new_pckg)


func _on_filters_filtered_by(tag, show_all):
	var deals = on_sale_container.get_children()
	for d in deals:
		d.visible = d.item_linked.class_==tag if !show_all else true
