class_name MemManufactor extends Manufactor
	
var component_class = 'memory'
func generate_components():
	var mems = []
	
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'RAM Revengeance 16GB 1333Mhz'
	cdata.specs = { 'size':16 }
	cdata.required_components = {}
	mems.append(cdata)
	return mems
