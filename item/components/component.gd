class_name Component extends Item

signal mouse_selected
export (Color) var placeholder_albedo
onready var collision_shape = find_node("StaticBody")
var slots = []
var installed_components = []  #nodes
var placeholder_mesh: Mesh


func _ready():
	# get data from component_database using node's name
	for cdata in Market.components_database:
		if self.name == str(cdata.class,"-",cdata.name):
			data = cdata
	collision_shape.owner = self  #ease access to component from the staticBody
	
	Events.connect("cmp_uninstalled", self, "_on_cmp_uninstalled")


func install_component(cdata:Dictionary, pbuild):
	if cdata.installed: 
		Events.emit_signal("cmp_alrdy_installed",cdata)
		return false
	
	slots = $slots.get_children()
	for s in slots:
		if s.name == str('s-',cdata.class):
			# if slot have subslots
			if s.get_child_count() > 0:
				for ss in s.get_children():
					# if subslot is free
					if ss.get_child_count() == 0:
						## install in sub_slot ##
						if add_component(cdata,ss,pbuild):
							return true
				Events.emit_signal("no_free_slot",cdata)
			else:
				## install in unique slot ##
				if add_component(cdata,s,pbuild):
					return true
	## this component hasnt any slot available for component ##
	for ic in installed_components:
		if ic.install_component(cdata,pbuild):
			return true


func add_component(cdata:Dictionary, parent:Node, pbuild):
	var component = Inventory.get_item_from_dict(cdata)
	if !component:
		var path = str("res://item/components/custom_components/starter_",cdata.class_,".tscn")
		component = load(path).instance()
		component.data = cdata
	
	cdata.installed = true
	Utils.change_parent(component,parent)
	installed_components.append(component)
	cdata.parent_build = pbuild
	cdata.parent_build[cdata.class] = component
	Events.emit_signal("cmp_installed",cdata)
	return true


func uninstall():
	if data.class != 'build':
		data.parent_build.uninstall_component(data)


func _on_cmp_uninstalled(cdata):
	for ic in installed_components:
		if ic.data.id == cdata.id:
			Utils.change_parent(ic, Inventory.item_nodes)
			installed_components.remove(installed_components.find(ic))


func disable_collision(disable:bool):
	 collision_shape.get_node("CollisionShape").disabled = disable

# set and returns the component mesh to use it as placeholder in slots and surfaces
func get_placeholder_mesh(meshInstance:MeshInstance) -> Mesh:
	if !placeholder_mesh:
		placeholder_mesh = collision_shape.get_parent().mesh
	
	var mat = SpatialMaterial.new()
	mat.flags_transparent = true
	mat.albedo_color = placeholder_albedo
	meshInstance.material_override = mat
	meshInstance.mesh = placeholder_mesh
	
	return placeholder_mesh
