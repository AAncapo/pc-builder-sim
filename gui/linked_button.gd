class_name LinkedButton extends Button

signal _pressed(button)
signal _mouse_enter(button)
signal _mouse_exit(button)

enum DisplayMode {
	Simple,
	Shopping
}
var display_mode = DisplayMode.Simple setget setDisplaymode
var item_linked setget setItem
func setItem(value):
	item_linked = value
	
	$"%name_".text = str(item_linked.name_)
	if item_linked.has('initial_price'):
		$"%price".text = str('$',item_linked.initial_price).pad_decimals(2)
	update_size()


func _ready():
	connect("pressed", self, "_on_pressed")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	self.display_mode = 0


func setDisplaymode(value):
	display_mode = value
	
	match display_mode:
		DisplayMode.Simple:
			$"%price".hide()
			$"%posted".hide()
			$"%new".hide()
		DisplayMode.Shopping:
			$"%price".show()
			$"%posted".show()
			$"%new".show()


func update_size():
	rect_min_size = $HBoxContainer.rect_size




func _on_pressed():
	emit_signal("_pressed", self)
func _on_mouse_entered():
	emit_signal("_mouse_enter", self)
func _on_mouse_exited():
	emit_signal("_mouse_exit", self)
