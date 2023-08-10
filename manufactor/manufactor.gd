class_name Manufactor extends Node

var cpu_models = ['Nova','Hyper','Ripper']


func generate_mobo():
	var mobos = []
	var mobo_dict = {}
	mobo_dict.id = Utils.generate_id()
	mobo_dict.item_class = 'motherboard'
	mobo_dict.parent_class = 'case'
	mobo_dict.name_ = 'MEGABYTE Z99 DDR3'
	mobo_dict.form_factor = 'ATX'
	mobo_dict.ram_slots = 2
	
	mobos.append(mobo_dict)
	return mobos


func generate_case():
	var cases = []
	var case = {}
	case.id = Utils.generate_id()
	case.item_class = 'case'
	case.parent_class = 'build'
	case.name_ = 'Thermaltake 222 EVo'
	case.form_factor = 'MidTower'
	case.hdd_slots = 2
	
	cases.append(case)
	return cases


func generate_cpu():
	var cpus = []
	var cur_gen = 1
	var cores = 2
	var cache = 2.0
	var threads = 0
	var frequency = 1.6
	for g in range(cpu_models.size()):
		var cur_series_max = 200
		var mdl = cpu_models[g]
		var serie = 100
		while(serie < cur_series_max):
			var cpu = {
				'id':Utils.generate_id(),
				'item_class':'cpu',
				'parent_class':'motherboard',
				'name_':str(mdl,' ',cur_gen,serie,' ',frequency,'Ghz ',cores,'-core',' ',threads,' threads ',cache,'mb cache'),
				'model':mdl,
				'gen':cur_gen,
				'serie':serie,
				'cores':cores,
				'cache':floor(cache),
				'threads':threads,
				'base_frecuency':frequency,
				}
			cpus.append(cpu)
			serie += 10
			cores += 2
			cache += 0.1
			threads += 2
			frequency += 0.1
		
		cur_gen += 1
		cur_series_max += 100
	
	return cpus

func generate_ram():
	var rams = []
	var ram_dict = {}
	ram_dict.id = Utils.generate_id()
	ram_dict.item_class = 'ram'
	ram_dict.parent_class = 'motherboard'
	ram_dict.name_ = 'Corsair 4GB 1333Mhz'
	
	rams.append(ram_dict)
	return rams

func generate_cooler():
	var coolers = []
	var cooler_dict = {}
	cooler_dict.id = Utils.generate_id()
	cooler_dict.item_class = 'cooler'
	cooler_dict.parent_class = 'motherboard'
	cooler_dict.name_ = 'CoolerMaster'
	
	coolers.append(cooler_dict)
	return coolers

func generate_psu():
	var psus = []
	var psu_dict = {}
	psu_dict.id = Utils.generate_id()
	psu_dict.item_class = 'psu'
	psu_dict.parent_class = 'case'
	psu_dict.name_ = 'EVGA 600w'
	
	psus.append(psu_dict)
	return psus

func generate_hdd():
	var hdds = []
	var hdd_dict = {}
	hdd_dict.id = Utils.generate_id()
	hdd_dict.item_class = 'hdd'
	hdd_dict.parent_class = 'case'
	hdd_dict.name_ = 'Seagate 1TB'
	
	hdds.append(hdd_dict)
	return hdds
