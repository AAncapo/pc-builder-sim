class_name LinkedButton extends Control

signal _pressed(button)
signal _mouse_enter(button)
signal _mouse_exit(button)

enum DisplayMode {
	Simple,
	Shopping
	}
var display_mode = DisplayMode.Simple setget setDisplaymode
var item_linked: Dictionary setget setItem
func setItem(value):
	item_linked = value
	_update(item_linked)
var toggle: bool setget set_toggle


func _ready():
	Events.connect("cmp_installed",self,'_update')
	$"%Button".connect("pressed", self, "_on_pressed")
	$"%Button".connect("mouse_entered", self, "_on_mouse_entered")
	$"%Button".connect("mouse_exited", self, "_on_mouse_exited")
	self.display_mode = 0


func _update(cmp = item_linked):
	if cmp != item_linked:
		return
	$"%item_name".text = str(cmp.name_)
	$"%icon".texture = cmp.class_icon if cmp.has('class_icon') else null
	if cmp.has('installed'):
		$"%installed".self_modulate = Color(1,1,1,0.5) if !cmp.installed else Color(1,0,0,1)
	else:
		$"%installed".hide()


func setDisplaymode(value):
	display_mode = value
	##TODO


func set_toggle(value):
	toggle = value
	$"%Button".toggle_mode = true
	$"%Button".pressed = value
	_update(item_linked)


func _on_pressed():
	emit_signal("_pressed", self)
func _on_mouse_entered():
	emit_signal("_mouse_enter",self)
func _on_mouse_exited():
	emit_signal("_mouse_exit",self)
