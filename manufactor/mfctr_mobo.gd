class_name MoboManufactor extends Manufactor

var component_class = 'motherboard'
func generate_components(amount):
	var mobos = []
	for _n in amount:
		var cdata = {}
		cdata.node = null
		cdata.installed = false
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'MEGABYTE Z99'
		cdata.specs = { 'manufactor':'MEGABYTE','form_factor':'ATX','chipset':'LGA-1151', 'memory_slots':2,'sata_connectors':4,'HDMI_ports':1,'VGA_ports':1 }
		cdata.required_components = {'cpu':{},'memory':{}}
		cdata.initial_price = 100.00
		cdata.stable = true
		cdata.power_consumption = 20
		mobos.append(cdata)
	return mobos
