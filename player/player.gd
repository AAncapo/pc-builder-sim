class_name Player extends KinematicBody

onready var cam = $CamBase
onready var ray: RayCast = $CamBase/Camera/RayCast
onready var inventory: Inventory = $Inventory

var mouse_sensitivity = 0.07

var interact_obj: Interactable


func _ready():
	toggle_or_set_mouse_mode()
	Events.connect("interaction_exited", self, "_on_exit_interaction")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x,-90,90)
		cam.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
	
	if Input.is_action_just_pressed("interact"):
		if interact_obj:
			return
		if ray.is_colliding() && ray.get_collider() is Interactable:
			interact_obj = ray.get_collider()
			interact_obj.interact()
			toggle_or_set_mouse_mode()
	if Input.is_action_just_pressed("exit_interaction"):
		_on_exit_interaction()
	
	if event.is_action_pressed('inventory'):
		inventory.visible = !inventory.visible
		toggle_or_set_mouse_mode(0 if inventory.visible else 2)
	
	if event.is_action_pressed("ui_cancel"):
		if interact_obj:
			_on_exit_interaction()
			return
		toggle_or_set_mouse_mode()


func toggle_or_set_mouse_mode(mouse_mode:int = -1):
	#VISIBLE=0
	#CAPTURED=2
	if mouse_mode >= 0:
		Input.set_mouse_mode(mouse_mode)
		return
	mouse_mode = 0 if Input.get_mouse_mode() == 2 else 2
	Input.set_mouse_mode(mouse_mode)


func _on_exit_interaction():
	interact_obj.exit()
	interact_obj = null
	toggle_or_set_mouse_mode()
