class_name Case extends Component


func power_switch(pressed:bool, button:Button):
	button.text = 'ON' if !pressed else 'OFF'
	#tell the build to start the booting process
	if !pressed:
		data.parent_build.shutdown()
		return
	data.parent_build.startup()


func reset():
	print('rebooting..')
	data.parent_build.shutdown()
	yield(get_tree().create_timer(0.5,false),"timeout")
	data.parent_build.startup()
