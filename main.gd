extends Spatial

export (Array, PackedScene) var starter_pckg

func _ready():
	if starter_pckg:
		var pckg = starter_pckg[0]
		Events.emit_signal("new_package",pckg) # tells RECEIVER that there is a new pckg
