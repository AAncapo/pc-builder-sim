class_name MemManufactor extends Manufactor
	
var component_class = 'memory'
func generate_components(amount):
	var mems = []
	var cdata = {}
	for _n in amount:
		cdata.node = null
		cdata.installed = false
		cdata.id = Utils.generate_id()
		cdata.class_ = component_class
		cdata.name_ = 'Raiden X'
		cdata.specs = { 'manufactor':'Raiden','size':'16 GB','frequency':'1333 Mhz' }
		cdata.required_components = {}
		cdata.initial_price = 150.00  #50-8gb 150-16gb
		cdata.stable = true
		cdata.power_consumption = 10
		mems.append(cdata)
	return mems
