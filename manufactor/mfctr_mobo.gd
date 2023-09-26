class_name MoboManufactor extends Manufactor

var component_class = 'motherboard'
func generate_components():
	var mobos = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'MOBO MEGABYTE Z99 DDR3'
	cdata.specs = { 'form_factor':0, 'memory_slots':2 }
	cdata.required_components = {'cpu':{},'memory':{}}
	cdata.initial_price = 100.00
	
	mobos.append(cdata)
	return mobos
