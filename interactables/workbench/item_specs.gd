extends Control

onready var header_label := $"%header"
onready var info:RichTextLabel = $"%info"
var cdata:Dictionary setget set_component


func _ready():
	hide()


func set_component(value):
	if value != null && value.class_ == 'build': return
	cdata = value
	if cdata == null: 
		pop_out()
		return
	header_label.text = cdata.name_
	yield(pop_out(),"completed")
	popup()
	update_data()


func update_data():
	info.clear()
	if cdata.has('specs'):
		var specs:Dictionary = cdata.specs
		for s in specs.keys():
			var spx = str(specs[s])
			if specs[s] is float: spx = str(specs[s]).pad_decimals(1)
			var spec = str(s.capitalize(),': ',spx)
			info.add_text(spec)
			info.newline()
		$AnimationPlayer.play("typewriting")


var t_duration = 0.3
func popup():
	show()
	self.rect_scale = self.rect_scale * 0.5
	self.modulate = Color(1,1,1,0)
	var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	t.parallel().tween_property(self,'rect_scale',Vector2(1,1),t_duration)
	t.parallel().tween_property(self,'modulate',Color(1,1,1,1),t_duration)


func pop_out():
	var t = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	t.tween_property(self,'rect_scale',self.rect_scale*0.5,t_duration/2)
	t.parallel().tween_property(self,'modulate',Color(1,1,1,0),t_duration/2)
	yield(t,"finished")


func _on_uninstall_pressed():
	cdata.parent_build.uninstall_component(cdata)
