class_name MemManufactor extends Manufactor
	
var component_class = 'memory'
func generate_components():
	var mems = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'RAM Revengeance 16GB 1333Mhz'
	cdata.specs = { 'size':16 }
	cdata.required_components = {}
	cdata.initial_price = 150.00  #50-8gb 150-16gb
	mems.append(cdata)
	return mems
