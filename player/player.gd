class_name Player extends KinematicBody

export (bool) var apply_gravity

onready var cam = $CamBase
onready var raycast = $"%RayCast"
onready var hand = $"%hand"
onready var hand_default_pos = hand.translation
var gravity = -30
var max_speed = 5.0
var velocity = Vector3()
var m_sens = 0.005

var item_to_equip
var equipping := false
var unequipping := false
var equipped: Component setget set_equipped_item
func set_equipped_item(value):
	$"%CollisionShape".disabled = true if value == null else false
	equipped = value

var release_pos
var release_surface


func _ready():
	Input.set_mouse_mode(2)


func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * m_sens)
		cam.rotate_x(-event.relative.y * m_sens)
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x,-90,70)


func _process(delta):
	if equipping && item_to_equip:
		# run grab animation
		move_hand(hand.global_translation, item_to_equip.global_translation, delta)
		return
	if unequipping && equipped:
		# run release animation
		move_hand(hand.global_translation, release_pos, delta)
		return
	# keep hand in default position
	hand.translation = lerp(hand.translation, hand_default_pos, delta * 6)
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if Input.is_action_just_pressed("grab_install"):  #left click
			## if NOT equipped exist, equipped selected item
			if collider.owner is Item && !equipped:
				collider.owner.disable_collision(true)
				equipping = true  # start equipping animation 
				item_to_equip = collider.owner
				return
			elif collider.is_in_group("surface") && equipped:
				if !release_pos: release_pos = raycast.get_collision_point()
				release_surface = collider.owner
				unequipping = true  # start unequipping animation
				release_pos = null
			#TODO: exchange items
		
		# display placeholder while item equipped and NOT released
		if collider.is_in_group("surface") && equipped:
			release_pos = raycast.get_collision_point()
			equipped.placeholder_v.global_translation = release_pos
			equipped.placeholder_v.global_rotation = raycast.get_collision_normal()
			equipped.placeholder_v.show()


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


func move_hand(start_pos, end_pos, delta):
	var dist = (end_pos - start_pos)
	hand.global_translate(dist.normalized() * 5 * delta)
	if dist.length() < 0.2:
		if equipping: grab_item(item_to_equip)
		if unequipping: release_item(release_surface)
		
		equipping = false
		unequipping = false
		item_to_equip = null
		release_surface = null


func grab_item(item:Item):
	for pos in $"%item_holder".get_children():
		if pos.name == str(item.data.class,"_holder"):
			Utils.change_parent(item, pos)
			item.global_transform = pos.global_transform
			self.equipped = item
			return


func release_item(surface):
	equipped.placeholder_v.hide()
	var rot = equipped.placeholder_v.global_transform
	Utils.change_parent(equipped,surface)
	equipped.global_transform = rot
	equipped.disable_collision(false)
	self.equipped = null
