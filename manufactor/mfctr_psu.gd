class_name PsuManufactor extends Manufactor

var component_class = 'psu'
func generate_components():
	var psus = []
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'PSU EVGA 600w'
	cdata.specs = {}
	psus.append(cdata)
	return psus
