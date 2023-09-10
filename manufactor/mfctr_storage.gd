class_name StorageManufactor extends Manufactor

var component_class = 'storage'
func generate_components():
	var hdds = []
	var cdata = {}
	cdata.installed = false
	cdata.id = Utils.generate_id()
	cdata.class_ = component_class
	cdata.name_ = 'HDD Seagate 1TB'
	cdata.specs = { 'size':1000 }
	hdds.append(cdata)
	return hdds
