extends Control
## Init ##
	# every time a new item is added to the inventory if is Component adds it here (component_list)
## Add component to current build ##
	# when component-button is pressed emit(install_component) -> buildbench
	# if component gets installed build_project emit(remove_from_inv) connected to self._on_bp_item_installed() and deletes the component from components list

signal install_component(component)

#onready var inv = load("res://player/inventory.tres")
onready var components := $"%comps_list"
var ibutton_temp = preload("res://gui/item_button.tscn")


func _ready():
	Events.connect("added_item_to_inv", self, "add_new_component")
	Events.connect("removed_item_from_inv", self, "_on_bp_item_installed")


func add_new_component(item):
	if item is Component:
		var new_button = ibutton_temp.instance()
		new_button.item_linked = item
		components.add_child(new_button)
		
		new_button.connect("_pressed", self, "__on_ibutton_pressed")


func _on_bp_item_installed(item:Item):
	for button in components.get_children():
		if button.item_linked.id_ == item.id_:
			button.queue_free()


func __on_ibutton_pressed(button):
	emit_signal("install_component",button.item_linked)
