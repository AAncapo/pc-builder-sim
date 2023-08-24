extends Control

onready var componentButtons := $"%cbuttons"


func update_status(current_bp:Dictionary):
	var installed_components = current_bp.get('installed_components')
	if installed_components:
		for ic in installed_components:
			for cb in componentButtons.get_children():
				if cb.name == ic.item_class:
					cb.component_linked = ic
