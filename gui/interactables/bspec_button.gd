extends HBoxContainer

signal _pressed(cdata, class_)

onready var buttons = $Buttons.get_children()
var class_
var cdata setget set_component
func set_component(value):
	cdata = value
	if !cdata:
		$Button.text = 'Not Installed'
		$Buttons/uninstall.hide()
		return
	$Button.text = cdata.name_
	$Buttons/uninstall.show()


func _ready():
	if !cdata:
		$Button.text = 'Not Installed'
		$Buttons/uninstall.hide()


func _on_uninstall_pressed():
	cdata.parent_build.uninstall_component(cdata)
	cdata = null


func _on_Button_pressed():
	#show component specs window
	emit_signal("_pressed", cdata, class_)
