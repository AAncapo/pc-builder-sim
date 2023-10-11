class_name Motherboard extends Component

enum FormFactor {
	ATX,
	MicroATX
	}
var form_factor = FormFactor.ATX
var memory_slots:int
var bios


func _process(_delta):
	if power_supply:
		if power_supply.draw_pwr(data.power_consumption):
			#returning needed amount of power
			pass



	#start bios
	pass
