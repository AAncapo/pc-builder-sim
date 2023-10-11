class_name CaseManufactor extends Manufactor

var component_class = 'case'
func generate_components(amount):
	var cases = []
	for _n in amount:
		var cdata = {}
		cdata.installed = false
		cdata.node = null
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'Sentinel III'
		cdata.specs = {'manufactor':'Sentinel','form_factor':'ATX','storage_slots':2}
		cdata.required_components = {'motherboard':{},'psu':{},'storage':{}}
		cdata.initial_price = 50.00
		cdata.stable = true
		cdata.power_consumption = 0
		cases.append(cdata)
	return cases
