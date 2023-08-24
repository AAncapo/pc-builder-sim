class_name Psu extends Component

# power delivered from the wall is NOT being emulated
# so efficiency ratings... might be added but do nothing 

var connected_to_wall: bool = false
var power_switch_on: bool = true
var is_working: bool = false
var total_power_output: int
var pwr_delivered: int
var power_efficiency_percent: int
var fan_speed: float
var fan_min_speed: float
var fan_max_speed: float
var temperature: float
var max_temperature: float
var is_overheating: bool

var connected_mobo
var connected_cpu
var connected_pcie


func _process(delta):
	if connected_to_wall:
		if power_switch_on:
			if is_working:
				pass
