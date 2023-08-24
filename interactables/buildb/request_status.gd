extends Control

onready var stats = $PanelContainer/VBoxContainer/stats
var current_build_data setget setBuild

func setBuild(b):
	current_build_data = b
	
	$PanelContainer/VBoxContainer/bname.text = current_build_data.name_
	Utils.remove_all_children(stats)
	var br:BuildRequest = b.get('request')
	if br:
		var br_keys = br.specs.keys()
		for cname in br_keys:
			if br.specs[cname].empty():
				continue
			for cspec in br.specs[cname].keys():
				var label = Label.new()
				# CPU Cores: 8
				var cn = cname.to_upper() if cname.length()<=3 else cname.capitalize()
				label.text = str(cn,' ',cspec.capitalize(),': ', br.specs[cname][cspec])
				stats.add_child(label)
				
				## Check status ##
				var bic = b.get('installed_components') #dicts array
				if bic:
					for ic in bic:
						if ic.get('item_class') == cname:
							if int(ic.get(cspec)) >= int(br.specs[cname][cspec]):
								print(int(ic.get(cspec)),'/',int(br.specs[cname][cspec]),'ok')
