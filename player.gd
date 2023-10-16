class_name Player extends KinematicBody

export (bool) var apply_gravity

onready var cam = $CamBase
onready var raycast = $"%RayCast"
var gravity = -30
var max_speed = 8.0
var velocity = Vector3()
var m_sens = 0.005

var equipped: Component setget set_equipped_item
func set_equipped_item(value):
	$"%CollisionShape".disabled = true if value == null else false
	equipped = value

var rotating_item:bool = false
var release_pos


func _ready():
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		if !rotating_item:
			self.rotate_y(-event.relative.x * m_sens)
		else:
			equipped.placeholder_v.global_rotation.y -= event.relative.x * m_sens
		cam.rotate_x(-event.relative.y * m_sens)
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x,-70,70)


func _process(delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if Input.is_action_just_pressed("grab_uninstall"):
			if collider.owner is Item:
				collider.owner.disable_collision(true)
				grab_item(collider.owner)
		
		if collider.is_in_group("surface"):
			if equipped:
				# DISPLAY placeholder while item equipped and NOT released
				release_pos = raycast.get_collision_point()
				if !rotating_item:
					equipped.placeholder_v.global_translation = release_pos
				equipped.placeholder_v.show()
				print('ee')
				# ROTATE placeholder while LEFT click is being holded 
				if Input.is_action_pressed("release_install"):
					rotating_item = true
				# RELEASE item when LEFT click is released
				if Input.is_action_just_released("release_install"):
					rotating_item = false
					equipped.placeholder_v.hide()
					var item = release_item(collider.owner,release_pos)
					release_pos = null
					if item: item.disable_collision(false)


func _physics_process(delta):
	if apply_gravity:
		velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)


func get_input():
	var input_dir = Vector3()
	
	if Input.is_action_pressed("forward"):
		input_dir += -cam.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += cam.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -cam.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += cam.global_transform.basis.x
	
	input_dir = input_dir.normalized()
	return input_dir


func grab_item(item:Item):
	for pos in $"%item_holder".get_children():
		if pos.name == str(item.data.class,"_holder"):
			Utils.change_parent(item, pos)
			item.global_transform = pos.global_transform
			self.equipped = item


func release_item(surface,pos:Vector3):
	var item = equipped
	var rot = equipped.placeholder_v.global_transform
	Utils.change_parent(item,surface)
	item.global_transform.origin = pos
	item.global_transform = rot
	self.equipped = null
	return item
