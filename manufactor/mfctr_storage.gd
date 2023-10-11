class_name StorageManufactor extends Manufactor

var component_class = 'storage'
func generate_components(amount):
	var hdds = []
	for _n in amount:
		var cdata = {}
		cdata.node = null
		cdata.installed = false
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'Raiden 1TB'
		cdata.specs = { 'manufactor':'Raiden','size':'1 TB','speed':'5200 RPM' }
		cdata.initial_price = 50.00
		cdata.stable = true
		cdata.power_consumption = 10
		hdds.append(cdata)
	return hdds
