class_name Psu extends Component

# power delivered from the wall is NOT being emulated
# so efficiency ratings... might be added but do nothing 

var total_supply:float
var supply_left:float

func set_data(value):
	data = value
	
	total_supply = data.specs.wattage
	supply_left = total_supply

func _init_():
	supply_left = total_supply
	._init_()


func draw_pwr(pwr_to_draw):
	supply_left = total_supply - pwr_to_draw
	if supply_left > 0:
		return true
