extends Control

signal start_new_build
signal item_selected(dict)

onready var commands := $"%Commands"
onready var buildsContainer := $"%Builds"
onready var specsPanel := $"%Specs"
onready var cmpPanel := $"%Components"


func _ready():
	Events.connect("cmp_installed",self,"_on_cmp_installed")
	Events.connect("cmp_uninstalled",self,"_on_cmp_uninstalled")
	Events.connect("cmp_alrdy_installed",self,"_on_cmp_alrdy_installed")
	Events.connect("no_free_slot",self,"_on_no_slot_free")
	
	$"%InstalledParts".hide()
	var sls = $"%specs".get_children()
	for s in sls:
		var spec = s.find_node('spec')
		spec.connect('_pressed',self,'_on_cspec__pressed')
		spec.class_ = s.name.to_lower()


func _on_new_build_pressed():
	emit_signal("start_new_build")

func _on_cmp_installed(cdata):
#	update_notif_label(str(cdata.name_,' INSTALLED!'))
	
#   ===== Update InstalledParts =====
	var sls = $"%specs".get_children()
	for s in sls:
		if s.name.to_lower() == cdata.class_:
			var cspec = s.get_child(1).get_node('spec')
			cspec.cdata = cdata

func _on_cmp_uninstalled(cdata):
#	update_notif_label(str(cdata.name_,' UNINSTALLED!'))

#   ===== Update InstalledParts =====
	var sls = $"%specs".get_children()
	for s in sls:
		if s.name.to_lower() == cdata.class_:
			var cspec = s.get_child(1).get_node('spec')
			cspec.cdata = null

func _on_no_slot_free(cdata):
#	update_notif_label(str('No Slot Available for ',cdata.name_))
	pass
func _on_cmp_alrdy_installed(cdata):
#	update_notif_label(str(cdata.name_,' already installed!'))
	pass

func update_notif_label(new_text):
	var notif_lbl = $"%notification"
	notif_lbl.text = new_text
	notif_lbl.show()
	yield(get_tree().create_timer(3,true),"timeout")
	notif_lbl.hide()


func _on_Builds_item_button_pressed(button):
	emit_signal("item_selected",button.item_linked)
	# set buildsPanel to the left corner
	var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(buildsContainer,'rect_position',Vector2.ZERO,0.5)
	
	Events.emit_signal('move_camera_pls')
	yield(t,"finished")
	$"%InstalledParts".show()
	$"%InstalledParts".rect_scale *= 0.5
	
	var t2 = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t2.tween_property($"%InstalledParts",'rect_scale',Vector2(1,1),0.3)
	$"%new_build".hide()
	$"%show_more".show()


func _on_Components_item_button_pressed(button):
	emit_signal("item_selected",button.item_linked)


func _on_workbench_ui_visibility_changed():
	if visible && !get_parent().active_build:
		var bstart_pos = Vector2((rect_size.x/2)-buildsContainer.rect_size.x/2, rect_size.y/2-buildsContainer.rect_size.y/2)
		buildsContainer.rect_position = bstart_pos

####################### BUILD PANELS #######################
func _on_cspec__pressed(cdata,class_):
	commands.cdata = cdata
	if !cdata:
		$"%Components".display(class_,'Install...')
		return
	$"%Specs".cdata = cdata
############################################################
