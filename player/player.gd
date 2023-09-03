class_name Player extends KinematicBody

onready var cam = $CamBase
onready var ray: RayCast = $CamBase/Camera/RayCast

var mouse_sensitivity = 0.07

var interact_obj: Interactable
var camera_locked := false


func _ready():
	toggle_or_set_mouse_mode()
	Events.connect("interaction_ended", self, "_on_interaction_ended")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && !camera_locked:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x,-90,90)
		cam.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
	
	if Input.is_action_just_pressed("interact"):
		if interact_obj:
			return
		if ray.is_colliding() && ray.get_collider() is Interactable:
			interact_obj = ray.get_collider()
			enter_interaction(interact_obj)
			toggle_or_set_mouse_mode()
	
	if event.is_action_pressed("ui_cancel"):
		if interact_obj:
			_on_interaction_ended()
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


func enter_interaction(obj:Interactable):
	$"%cursor".hide()
	camera_locked = true
	cam.look_at(obj.interaction_point.global_translation,Vector3.UP)
	interact_obj.enter()
#	Events.emit_signal("interaction_started",interact_obj)


func _on_interaction_ended():
	$"%cursor".show()
	interact_obj.exit()
	interact_obj = null
	camera_locked = false
	toggle_or_set_mouse_mode()
