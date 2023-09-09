class_name MoboManufactor extends Manufactor

var component_class = 'motherboard'
func generate_components():
	var mobos = []
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'MOBO MEGABYTE Z99 DDR3'
	cdata.specs = { 'form_factor':0, 'memory_slots':2 }
	cdata.required_components = {'cpu':{},'memory':{}}
	
	mobos.append(cdata)
	return mobos
