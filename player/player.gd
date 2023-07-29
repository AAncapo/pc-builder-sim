class_name Player extends KinematicBody

onready var cam = $CamBase
onready var ray: RayCast = $CamBase/Camera/RayCast
var mouse_sensitivity = 0.07

var interact_obj: Interactable

var inventory


func _ready():
	toggle_mouse_mode()
	if !inventory:
		inventory = Inventory.new()
	
	Events.connect("interaction_exited", self, "_on_exit_interaction")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if interact_obj:
			_on_exit_interaction()
		else:
			if ray.is_colliding() && ray.get_collider() is Interactable:
				interact_obj = ray.get_collider()
				interact_obj.interact()
				toggle_mouse_mode()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x,-90,90)
		cam.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
	
	if event.is_action_pressed("ui_cancel"):
		if interact_obj:
			_on_exit_interaction()
			return
		toggle_mouse_mode()


func toggle_mouse_mode():
	var mouse_mode = 0 if Input.get_mouse_mode() == 2 else 2
	Input.set_mouse_mode(mouse_mode)


func _on_exit_interaction():
	interact_obj.exit()
	interact_obj = null
	toggle_mouse_mode()
