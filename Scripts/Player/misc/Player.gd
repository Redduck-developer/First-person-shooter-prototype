extends CharacterBody3D
class_name player

#developer variables
@export var dev_mode = false

#movement variables
var speed : float
const WALK_SPEED = 5.0 #5.0
const SPRINT_SPEED = 10.0 #10.0
const CROUCH_SPEED = 2.0 #2.0
const FLIGHT_SPEED = 20.75 #20.75
const JUMP_VELOCITY = 6 #6


var additive_speed : float
var STRAFE_SPEED = 0 #1.0
var LUNGE_SPEED = 0 #30.0


@export var MOVEABLE = false
var flight = false
var SENSITIVITY = 0.002 
var cayote = true
var is_in_water = false
var lunging = false

#bob variables
const BOB_FREQ = 2
const BOB_AMP = 0.06
var t_bob = 0.0

#Vbob variables
const VBOB_FREQ = 2
const VBOB_AMP = 0.01
var Vt_bob = 0.0

#preloaded variables
var Blood = preload("res://Scenes/misc/blood_decal.tscn")

#fov variables
const ZOOM_FOV = 40.0
var BASE_FOV = 90.0
const NORMAL_FOV = 90.0
const FOV_CHANGE = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8


@onready var head = $Head
@onready var camera = $Head/Camera3D

signal load_main

func _ready():
	SlotBase.KILL = false
	StatusManager._heal(100, true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(OS.get_name())
	print(OS.get_processor_name())
	print(OS.get_memory_info())
	print(OS.get_video_adapter_driver_info())
	print(RenderingServer.get_rendering_device().get_device_name())


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	if Input.is_action_just_pressed("lmb"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("ESC"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	if StatusManager.HURT_ANIM == true:
		_Blood_decal_inst($Head.global_position + Vector3(0,4,0))
		$"Bloodparticles 1".emitting = true
		$"Bloodparticles 2".emitting = true
		$Hurt.stop()
		$Hurt.play()
	
	if is_on_floor():
		if cayote == false:
			cayote = true
			$Land.play()
	global.obj_pickup_rotation = head.rotation
	
	
	if global.is_climbing == true:
		MOVEABLE = false
		position = global.Climbing_Pos
	else:
		MOVEABLE = true
	
	
	if MOVEABLE == true:
		# Add the gravity.
		if not is_on_floor():
			if flight == false:
				if is_in_water == false:
					velocity.y -= (gravity * 2) * delta
		if is_in_water == true:
			velocity.y -= (gravity * 2) * delta
		# Handle Jump.
		
		# Handle Sprint.
		
		
		#additive_speed stuff
		if Input.is_action_pressed("w") or Input.is_action_pressed("s"):
			if Input.is_action_pressed("d") or Input.is_action_pressed("a"):
				STRAFE_SPEED = 1.0
				#print(additive_speed)
				#print(speed)
			else:
				STRAFE_SPEED = 0.0
				#print(additive_speed)
				#print(speed)
		else:
			pass
		
		
		
		
		# Get the input direction and handle the movement/deceleration.
		var input_dir = Input.get_vector("a", "d", "w", "s")
		var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if is_on_floor():
			if direction:
				velocity.x = direction.x * (speed + additive_speed)
				velocity.z = direction.z * (speed + additive_speed)
				$Footsteps.volume_db = 10
			else:
				velocity.x = lerp(velocity.x, direction.x * (speed + additive_speed), delta * 7.0)
				velocity.z = lerp(velocity.z, direction.z * (speed + additive_speed), delta * 7.0)
				$Footsteps.volume_db = -80
		else:
			velocity.x = lerp(velocity.x, direction.x * (speed + additive_speed), delta * 1.0)
			velocity.z = lerp(velocity.z, direction.z * (speed + additive_speed), delta * 1.0)
			$Footsteps.volume_db = -80
		
		# Head bob
		if StatusManager.Health > 0:
			t_bob += delta * velocity.length() * float(is_on_floor())
			camera.transform.origin = _headbob(t_bob)
			if not Input.is_action_pressed("rmb"):
				$Head/Camera3D/VIEWMODEL.transform.origin = _VIEWMODEL_headbob(t_bob)
		
		
		# FOV
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
		
		global.playtrans = self.transform
		
		_Jump_control()
		_Dive_control()
		_Sprint_control()
		_Crouch_Control()
		_push_away_rigid_bodies()
		move_and_slide()

func _process(delta: float) -> void:
	if StatusManager.Health == 0:
		rotation_degrees.z = 90
		$Head.rotation_degrees.y = 0
		$Head/Camera3D.rotation_degrees = Vector3(0,0,0)
		MOVEABLE = false
		axis_lock_linear_x = true
		axis_lock_linear_z = true
	
	additive_speed = LUNGE_SPEED + STRAFE_SPEED
	
	global.headpos = $Head.global_position
	global.playpos = self.global_position
	
	if dev_mode == true:
		if Input.is_action_just_pressed("V"):
			flight = !flight
	
	if flight == true:
		if not Input.is_action_pressed("SPACE"):
			if not Input.is_action_pressed("SHIFT"):
				velocity.y = 0
	


func _push_away_rigid_bodies():
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			var push_dir = -c.get_normal()
			# How much velocity the object needs to increase to match player velocity in the push direction
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - c.get_collider().linear_velocity.dot(push_dir)
			# Only count velocity towards push dir, away from character
			velocity_diff_in_push_dir = max(0., velocity_diff_in_push_dir)
			# Objects with more mass than us should be harder to push. But doesn't really make sense to push faster than we are going
			const MY_APPROX_MASS_KG = 70.0
			var mass_ratio = min(1., MY_APPROX_MASS_KG / c.get_collider().mass)
			# Optional add: Don't push object at all if it's 4x heavier or more
			if mass_ratio < 0.15:
				continue
			# Don't push object from above/below
			push_dir.y = 0
			# 5.0 is a magic number, adjust to your needs
			var push_force = mass_ratio * 2
			c.get_collider().apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, c.get_position() - c.get_collider().global_position)

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _VIEWMODEL_headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * VBOB_FREQ) * VBOB_AMP
	pos.x = cos(time * VBOB_FREQ / 2) * VBOB_AMP
	return pos

#Movement_controls

func _Crouch_Control():
	if Input.is_action_just_pressed("CTRL"):
		$Crouch_animation.play("crouch")
	if Input.is_action_just_released("CTRL"):
		if $RayCast3D.is_colliding() == false:
			$Crouch_animation.play_backwards("crouch")

func _Sprint_control():
	if not Input.is_action_pressed("CTRL"):
		if Input.is_action_pressed("SHIFT"):
			if StatusManager.depleted == false:
				if not Input.is_action_pressed("rmb"):
					speed = SPRINT_SPEED
					$Footsteps.pitch_scale = 2
				else:
					speed = WALK_SPEED
					$Footsteps.pitch_scale = 1
				if flight == true:
					velocity.y = -JUMP_VELOCITY
			else:
				if not Input.is_action_pressed("rmb"):
					speed = WALK_SPEED
					$Footsteps.pitch_scale = 1
				else:
					speed = WALK_SPEED
					$Footsteps.pitch_scale = 1
				if flight == true:
					velocity.y = -JUMP_VELOCITY
		elif not Input.is_action_pressed("CTRL"):
			speed = WALK_SPEED
			
	#Handle Crouch
	if Input.is_action_pressed("CTRL"):
		speed = CROUCH_SPEED
		$Footsteps.pitch_scale = 0.4
	elif not Input.is_action_pressed("SHIFT"):
		speed = WALK_SPEED
		$Footsteps.pitch_scale = 1

func _Dive_control():
	if lunging == false:
		if is_on_floor():
			if Input.is_action_just_pressed("CTRL + SPACE"):
				velocity.y = JUMP_VELOCITY
				cayote = false
				if StatusManager.depleted == false:
					LUNGE_SPEED = 30.0
					StatusManager.stamina = 0
					StatusManager.depleted = true
					lunging = true
					print(additive_speed)
	else:
		if is_on_floor():
			lunging = false
			LUNGE_SPEED = 0.0
		else:
			LUNGE_SPEED = 30.0

func _Jump_control():
	if flight == false:
		if Input.is_action_just_pressed("SPACE") and is_on_floor(): 
			$Jump.play(0.0)
			velocity.y = JUMP_VELOCITY
			cayote = false
		elif Input.is_action_just_pressed("SPACE") and cayote == true:
			$Jump.play(0.0)
			velocity.y = JUMP_VELOCITY
			cayote = false
	elif flight == true:
		if Input.is_action_just_pressed("SPACE"): 
			velocity.y = JUMP_VELOCITY
			speed = FLIGHT_SPEED

#IDK

func _on_hurtbox_area_entered(area: Area3D) -> void:
	if area is light_bullet_enemy:
		StatusManager._hurt(10)
	if area is Medium_bullet_enemy:
		StatusManager._hurt(20)
	if area is water:
		$Splash.play(0.0)
		gravity = -2.2
		is_in_water = true
		velocity.y = -3
	if area is Tramp:
		$Jump.play()
		cayote = false
		velocity.y = global.jump

func _on_hurtbox_area_exited(area: Area3D) -> void:
	if area is water:
		gravity = 9.8
		is_in_water = false


func _Blood_decal_inst(pos):
	var inst_Blood = Blood.instantiate()
	inst_Blood.position = pos
	add_child(inst_Blood)


func DEV_MODE():
	dev_mode = true


func _on_rl_pressed() -> void:
	get_tree().reload_current_scene()
	AmmoManager._delete_ammo()
	SlotBase._delete_all_slot_data()
