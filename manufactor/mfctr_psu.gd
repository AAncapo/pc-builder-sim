class_name PsuManufactor extends Manufactor

var component_class = 'psu'
func generate_components(amount):
	var psus = []
	for _n in amount:
		var cdata = {}
		cdata.node = null
		cdata.installed = false
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'VEGA 600W'
		cdata.specs = {'manufactor':'VEGA','wattage':600}
		cdata.initial_price = 50.00  # $50:500-600w  $80-$150: higher
		cdata.stable = true
		cdata.power_consumption = 0
		psus.append(cdata)
	return psus
