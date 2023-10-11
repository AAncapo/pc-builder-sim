class_name CoolerManufactor extends Manufactor

var component_class = 'cooler'
func generate_components(amount):
	var coolers = []
	for _n in amount:
		var cdata = {}
		cdata.node = null
		cdata.installed = false
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'Fujin'
		cdata.specs = {'manufactor':'Fujin','size':'140 mm'}
		cdata.initial_price = 10.00
		cdata.stable = true
		cdata.power_consumption = 5
		coolers.append(cdata)
	return coolers
