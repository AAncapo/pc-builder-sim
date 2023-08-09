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
