extends HBoxContainer
## Build component status label ##

func set_values(c_class,property,required,current):
	#TODO: use a RichTextlabel to adjust c_class font style
	$component_property.text = str(c_class,' ',property,':')
	$required.text = str(required)
	$current.text = str(current)
