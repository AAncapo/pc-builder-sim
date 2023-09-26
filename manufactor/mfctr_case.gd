class_name CaseManufactor extends Manufactor

var component_class = 'case'
func generate_components():
	var cases = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'CASE Thermaltake 222 EVo'
	cdata.specs = {'form_factor':0,'storage_slots':2}
	cdata.required_components = {'motherboard':{},'psu':{},'storage':{}}
	cdata.initial_price = 50.00
	cases.append(cdata)
	return cases
