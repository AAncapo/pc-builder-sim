extends Control

onready var stats = $PanelContainer/VBoxContainer/stats
var current_build

func update_br_status(b):
	if !b:
		$PanelContainer/VBoxContainer/bname.text = 'No Build Selected'
		return
	current_build = b.data
	
	$PanelContainer/VBoxContainer/bname.text = current_build.name_
	Utils.remove_all_children(stats)
	var br:BuildRequest = b.request
	if br:
		var br_keys = br.specs.keys()
		for cname in br_keys:
			if br.specs[cname].empty():
				continue
			for cspec in br.specs[cname].keys():
				## Check status ##
				var completed = false
				var bic = b.installed_components #dicts array
				if bic:
					for ic in bic:
						if ic.class_ == cname:
							completed = int(ic.get(cspec)) >= int(br.specs[cname][cspec])
				
				# CPU Cores: 8
				var label = Label.new()
				var cn = cname.to_upper() if cname.length()<=3 else cname.capitalize()
				label.text = str(cn,' ',cspec.capitalize(),': ', br.specs[cname][cspec],' -OK' if completed else ' ---')
				stats.add_child(label)
	$"%send".disabled = !b.is_completed()


func _on_send_pressed():
	Events.emit_signal("request_completed",current_build.request)
