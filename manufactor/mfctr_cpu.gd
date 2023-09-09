class_name CpuManufactor extends Manufactor

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
			cdata.id = Utils.generate_id()
			cdata.class_ = component_class
			cdata.name_ = name_
			cdata.specs = specs
			cdata.required_components = required_components
			
			cpus.append(cdata)
		currentGen += 1
	return cpus
