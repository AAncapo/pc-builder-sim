extends Spatial

var balance: float = 200.00

func _ready():
	$"%balance".text = str('BALANCE  $',Market.player_balance).pad_decimals(2)
	Events.connect("items_buyed",self,"_on_items_buyed")


func _on_items_buyed():
	$"%balance".text = str('BALANCE  $',Market.player_balance).pad_decimals(2)
