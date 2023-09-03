class_name Manufactor extends Node


class CpuManufactor:
	
	var component_class = 'cpu'
	var manufactor_name = 'CORE'
	var currentSerie:int = 100
	var serieStep:int = 55 if randf()<0.5 else 200
	
	const LAST_GEN:int = 10
	var currentGen:int = 1
	
	const MAX_CORES:int = 24
	const MIN_CORES:int = 2
	var coreStep:int = 2
	var currentCoreCount:int = 2
	
	const MAX_FREQUENCY:float = 4.0
	const MIN_FREQUENCY:float = 1.1
	var freqStep:float = 0.05
	var currentFreq:float = 1.0
	var required_components = {'cooler':{}}
	
	func generate_components() -> Array:
		var cpus = []
		while(currentGen <= LAST_GEN):
			var generated_per_gen = 5 if randf()<0.8 else 7
			for _m in range(generated_per_gen):
				## generate all cpus for the current model
				# assign serie
				var specs = {}
				specs.generation = currentGen
				specs.serie = currentSerie
				currentSerie += serieStep
				# assign frequency
				if currentFreq >= MAX_FREQUENCY:
					currentFreq = MAX_FREQUENCY
				specs.base_frequency = currentFreq
				specs.turbo_frequency = currentFreq+rand_range(currentFreq,currentFreq+rand_range(0.5,2.0))
				
				currentFreq += freqStep
				# assign cores
				if currentCoreCount >= MAX_CORES:
					currentCoreCount = MAX_CORES
				specs.cores = currentCoreCount
				if randf()>0.7:
					currentCoreCount += coreStep
				
				var name_ = str(manufactor_name,' ',specs['generation'],specs['serie'],' ',specs['cores'],'-core ',specs['base_frequency'],'Ghz')
				var component_data = {
					'id':Utils.generate_id(),
					'class_':component_class,
					'name_':name_,
					'specs':specs,
					'required_components':required_components
				}
				cpus.append(component_data)
			currentGen += 1
		return cpus

class MoboManufactor:
	var component_class = 'motherboard'
	func generate_components():
		var mobos = []
		var mobo = {
			'id':Utils.generate_id(),
			'class_':component_class,
			'name_':'MOBO MEGABYTE Z99 DDR3',
			'specs':{ 'form_factor':0, 'memory_slots':2 },
			'required_components':{'cpu':{},'memory':{}}
		}
		mobos.append(mobo)
		return mobos

class CaseManufactor:
	
	var component_class = 'case'
	func generate_components():
		var cases = []
		var case = {
			'id':Utils.generate_id(),
			'class_':component_class,
			'name_':'CASE Thermaltake 222 EVo',
			'specs':{'form_factor':0,'storage_slots':2},
			'required_components': {'motherboard':{},'psu':{},'storage':{}}
		}
		cases.append(case)
		return cases

class MemManufactor:
	
	var component_class = 'memory'
	func generate_components():
		var mems = []
		var mem = {}
		mem.id = Utils.generate_id()
		mem.class_ = component_class
		mem.name_ = 'RAM Revengeance 16GB 1333Mhz'
		mem.specs = { 'size':16 }
		mem.required_components = {}
		mems.append(mem)
		return mems

class CoolerManufactor:
	var component_class = 'cooler'
	func generate_components():
		var coolers = []
		var cooler = {}
		cooler.id = Utils.generate_id()
		cooler.class_ = component_class
		cooler.name_ = 'COOLER CoolerMaster'
		cooler.specs = {}
		coolers.append(cooler)
		return coolers

class PsuManufactor:
	var component_class = 'psu'
	func generate_components():
		var psus = []
		var psu = {}
		psu.id = Utils.generate_id()
		psu.class_ = component_class
		psu.name_ = 'PSU EVGA 600w'
		psu.specs = {}
		psus.append(psu)
		return psus

class StorageManufactor:
	
	var component_class = 'storage'
	func generate_components():
		var hdds = []
		var storage = {}
		storage.id = Utils.generate_id()
		storage.class_ = component_class
		storage.name_ = 'HDD Seagate 1TB'
		storage.specs = { 'size':1000 }
		hdds.append(storage)
		return hdds
