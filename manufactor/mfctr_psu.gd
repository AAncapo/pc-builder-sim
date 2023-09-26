class_name PsuManufactor extends Manufactor

var component_class = 'psu'
func generate_components():
	var psus = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'PSU EVGA 600w'
	cdata.specs = {'wattage':600}
	cdata.initial_price = 50.00  # $50:500-600w  $80-$150: higher
	psus.append(cdata)
	return psus
