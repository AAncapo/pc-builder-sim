class_name Interactable extends StaticBody

func _ready():
	if !has_method('interact'):
		print('WARNING: interactable ',name,' does not have a "interact()" function')
	if !has_method('exit'):
		print('WARNING: interactable ',name,' does not have a "exit()" function')


func interact():
	pass

func exit():
	pass
