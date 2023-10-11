class_name CpuManufactor extends Manufactor

var component_class = 'cpu'
var manufactor_name = 'SAF'
var currentSerie:int = 100
var serieStep:int = 55 if randf()<0.5 else 200

const LAST_GEN:int = 5
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


func generate_components(_amount) -> Array:
	var cpus = []
	while(currentGen <= LAST_GEN):
		var generated_per_gen = 5 if randf()<0.8 else 7
		for _m in range(generated_per_gen):
			## generate all cpus for the current model
			# assign serie
			var specs = {}
			specs.serie = currentSerie
			currentSerie += serieStep
			# assign frequency
			if currentFreq >= MAX_FREQUENCY:
				currentFreq = MAX_FREQUENCY
			specs.clock_speed = stepify(currentFreq,0.0)
			specs.turbo = stepify(currentFreq+rand_range(currentFreq,currentFreq+rand_range(0.5,2.0)),0.0)
			
			currentFreq += freqStep
			# assign cores
			if currentCoreCount >= MAX_CORES:
				currentCoreCount = MAX_CORES
			specs.cores = currentCoreCount
			if randf()>0.7:
				currentCoreCount += coreStep
			
			var name_ = str(manufactor_name,' ',specs['serie'],' ',specs['cores'],'-core ',specs['clock_speed'],'Ghz')
			specs.manufactor = manufactor_name
			var cdata = {}
			cdata.node = null
			cdata.installed = false
			cdata.id = Utils.generate_id()
			cdata.class_ = component_class
			cdata.name_ = name_
			cdata.specs = specs
			cdata.required_components = required_components
			cdata.initial_price = 100.00
			cdata.stable = true
			cdata.power_consumption = 20
			cpus.append(cdata)
		currentGen += 1
	return cpus
