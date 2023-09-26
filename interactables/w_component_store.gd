extends Control

onready var onSaleContainer = $"%OnSale"
var package_tscn = preload("res://packages/package.tscn")
var shopping_cart = []
var total_cost:float


func generate_item_deal(item):
	var deal = onSaleContainer.add_item(item,1)
	deal.connect("_pressed",self,"add_to_cart")


func buy_items_in_cart():
	if !shopping_cart.empty():
		
		## Add items in shopping cart to a Package ##
		var items = []
		for i in shopping_cart:
			items.append(i)
		
		## Remove button from shopping cart and Shop ##
		for i in items:
			for b in onSaleContainer.get_items():
				## TODO: Los items repetidos dejen de compartir ID (ocurre xq referencian al mismo Dict, si cambio el ID en uno se cambia en el resto)
				if b.item_linked.id == i.id:
					if !shopping_cart.empty():
						remove_from_cart(b,false)
					## TODO: add Stock counter ##
					### placeholder ###
					b.queue_free()
					###################
		
		var new_pckg: ItemsPackage = package_tscn.instance()
		new_pckg.create_new_package('Store',items)
		Events.emit_signal("new_package",new_pckg)
	
	Market.player_balance -= total_cost
	Events.emit_signal("items_buyed")


func add_to_cart(ib):
	shopping_cart.append(ib.item_linked)
	var button = $"%CartItems".add_item(ib.item_linked)
	if !button.is_connected("_pressed",self,"remove_from_cart"):
		button.connect("_pressed",self,"remove_from_cart")
	update_cost()
	$"%cart_size".text = str(shopping_cart.size())


func update_cost():
	total_cost = 0
	for i in shopping_cart:
		total_cost += i.initial_price
	$"%cost".text = str('Total Cost: $',total_cost).pad_decimals(2)
	$"%remaining".text = str('Remaining Cash: $',Market.player_balance - total_cost)


func remove_from_cart(b, _update_cost = true):
	shopping_cart.remove(shopping_cart.find(b.item_linked))
	for bt in $"%CartItems".get_items():
		if bt.item_linked.id == b.item_linked.id:
			bt.queue_free()
	if _update_cost: update_cost()
	$"%cart_size".text = str(shopping_cart.size())


func _on_open_cart_pressed():
	$"%Cart".popup()


func _on_Cart_confirmed():
	if total_cost > Market.player_balance:
		$"%Cart".show()
		return
	buy_items_in_cart()


func _on_FilterContainer_apply_filter(tag, show_all):
	var deals = onSaleContainer.get_items()
	for d in deals:
		d.visible = d.item_linked.class_==tag if !show_all else true
