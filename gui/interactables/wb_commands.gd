extends PanelContainer

onready var cmdBar = $"%CommandBar"
onready var end_margin := margin_top
onready var start_margin:= abs(end_margin)
var cdata setget setComponent
func setComponent(value):
	if value == cdata: return
	cdata = value
	if !cdata: 
		hide()
		return
	var cc = cdata.class_
	for cmd in cmdBar.get_children():
		cmd.visible = cmd.is_in_group(cc)
	
	margin_top = start_margin
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"margin_top",end_margin,0.1)


func _ready():
	margin_top = start_margin


func call_method(c:Component,m:String,params = []):
	if c.has_method(m): return c.callv(m,params)


func _on_on_off_toggled(button_pressed):
	var pwr_button = $"%on_off"
	call_method(cdata.parent_build[cdata.class_],'power_switch',[button_pressed,pwr_button])

func _on_reset_pressed():
	call_method(cdata.parent_build[cdata.class_],'reset')

func _on_thermal_paste_pressed():
	call_method(cdata.parent_build[cdata.class_],'apply_thermal_paste')
