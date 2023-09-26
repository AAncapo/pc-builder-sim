class_name CoolerManufactor extends Manufactor

var component_class = 'cooler'
func generate_components():
	var coolers = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'COOLER CoolerMaster'
	cdata.specs = {}
	cdata.initial_price = 10.00
	coolers.append(cdata)
	return coolers
