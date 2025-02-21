extends RigidBody3D
class_name FPS_R


var mouse_sensitivity := 0.002
var twist_input := 0.0
var pitch_input := 0.0
var lock = true
var vw = 1
var t = 0.0
var onground = true

#var can = preload("res://fps/utlz/prop_can.tscn")
#var table = preload("res://fps/utlz/prop_table.tscn")
#var bean = preload("res://fps/utlz/peacefullguy.tscn")
#var car = preload("res://fps/utlz/car?.tscn")
#var flashbang = preload("res://fps/utlz/flash_bang.tscn")
#var chair = preload("res://fps/utlz/chair.tscn")

@export var moveble = true

@warning_ignore("unused_signal")
signal waltuhded
signal telezerohundzero
signal telespawn
signal flash

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity




func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var input_a_d:= Input.get_axis("a", "d")
	
	if $ShapeCast3D.is_colliding() == true:
		onground = true
	else:
		onground = false
	
	t += delta
	if Input.is_action_just_pressed("Space"):
		if $ShapeCast3D.is_colliding() == true:
			if not $RayCast3D.is_colliding():
				if input_dir:
					if Input.is_action_pressed("SHIFT"):
						apply_force(Vector3(0,200,0))
					else:
						if Input.is_action_pressed("w"):
							apply_force(-twist_pivot.transform.basis.z * 175)
						if Input.is_action_pressed("s"):
							apply_force(twist_pivot.transform.basis.z * 225)
					apply_force(Vector3(0,335,0))
				else:
					apply_force(Vector3(0,425,0))
	global.playpos = position
	global.playtrans = $TwistPivot.transform
	global.obj_pickup_position = $"TwistPivot/PitchPivot/SpringArm3D2/object pickup regoin".global_position
	global.obj_pickup_rotation = $TwistPivot.rotation
	
	
						
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not Input.is_action_pressed("CTRL"):
		if moveble == true:
			if not Input.is_action_pressed("SHIFT"):
				if Input.is_action_pressed("w"):
					apply_force(-twist_pivot.transform.basis.z * 10)
				if Input.is_action_pressed("s"):
					apply_force(twist_pivot.transform.basis.z * 10)
				if Input.is_action_pressed("d"):
					apply_force(twist_pivot.transform.basis.x * 10)
					$TwistPivot/skeleton/torso.rotation_degrees.y = -9
				if Input.is_action_pressed("a"):
					apply_force(-twist_pivot.transform.basis.x * 10)
					$TwistPivot/skeleton/torso.rotation_degrees.y = 9
				$walk.speed_scale = 2
			if  Input.is_action_pressed("SHIFT"):
				if Input.is_action_pressed("w"):
					apply_force(-twist_pivot.transform.basis.z * 3.5)
				if Input.is_action_pressed("s"):
					apply_force(twist_pivot.transform.basis.z * 3.5)
				if Input.is_action_pressed("d"):
					apply_force(twist_pivot.transform.basis.x * 3.5)
					$TwistPivot/skeleton/torso.rotation_degrees.y = -10
				if Input.is_action_pressed("a"):
					apply_force(-twist_pivot.transform.basis.x * 3.5)
					$TwistPivot/skeleton/torso.rotation_degrees.y = 10
				$walk.speed_scale = 0.85
		if not Input.is_action_pressed("a") and not Input.is_action_pressed("d"):
			$TwistPivot/skeleton/torso.rotation.y = 0
	
	
	if not input_dir:
		if not Input.is_action_pressed("CTRL"):
			self.physics_material_override.friction = 1
		if not Input.is_action_pressed("SHIFT"):
			$walk.play("RESET")
		if Input.is_action_pressed("SHIFT"):
			$crouch.play("RESET")
		$TwistPivot/skeleton/torso.rotation.y = 0
	if input_dir:
		self.physics_material_override.friction = 0.05
		if lock == true:
			if not Input.is_action_pressed("SHIFT"):
				if onground == true:
					$walk.play("walk")
				if onground == false:
					$walk.stop()
			if Input.is_action_pressed("SHIFT"):
				if onground == true:
					$crouch.play("crouching")
				if onground == false:
					$crouch.stop()
			else:
				$crouch.pause()

		elif lock == false:
			$walk.play("RESET")
			$crouch.stop()
	if Input.is_action_pressed("R"):
		self.lock_rotation = false
	else:
		self.lock_rotation = true
		rotation = Vector3(0,0,0)
	
	if Input.is_action_pressed("CTRL") and input_dir and $ShapeCast3D.is_colliding() == true:
		linear_damp = 0.1
		$CollisionShape3D.scale = Vector3(1,0.2,1)
		if lock == true:
			apply_force(-twist_pivot.transform.basis.z * 500.5)
			$slide.play("SLIDE")
			lock = false
	elif not Input.is_action_pressed("CTRL"):
		scale = Vector3(1,1,1)
		linear_damp = 1
		if lock == false:
			$slide.play_backwards("SLIDE")
			lock = true
		if not Input.is_action_pressed("SHIFT"):
			$CollisionShape3D.scale = Vector3(1,1,1)
	if Input.is_action_pressed("SHIFT"):
		$CollisionShape3D.scale = Vector3(1,0.5,1)
	elif not Input.is_action_pressed("SHIFT"):
		if not Input.is_action_pressed("CTRL"):
			if not $RayCast3D.is_colliding():
				$CollisionShape3D.scale = Vector3(1,1,1)
	
	if Input.is_action_just_pressed("E"):
		if global.obj_is_pickuped == true:
			return
		else:
			$slash.play("SLASH")
		
	if Input.is_action_just_pressed("F"):
		if vw == 1:
			$view.play("3rd person")
		if vw == 3:
			$view.play_backwards("3rd person")
	if not Input.is_action_pressed("CTRL"):
		if Input.is_action_pressed("Z"):
			$TwistPivot/PitchPivot/Camera3D.fov = 20
		else:
			$TwistPivot/PitchPivot/Camera3D.fov = 90
	if global.obj_is_pickuped == true:
		$TwistPivot/PitchPivot/arm_base.visible = false
	else:
		$TwistPivot/PitchPivot/arm_base.visible = true
	
	if global.is_driving == true:
		moveble = false
	else:
		moveble = true
	
	$"TwistPivot/skeleton/torso/head joint".rotation.x = pitch_pivot.rotation.x
	
	
	
	
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-90), 
		deg_to_rad(90)
	)
	twist_input = 0.0
	pitch_input = 0.0
	if Input.is_action_just_pressed("B"):
		self.physics_material_override.bounce = 1
	if Input.is_action_just_pressed("N"):
		self.physics_material_override.bounce = 0
	
	if Input.is_action_just_pressed("x"):
		if $TwistPivot/PitchPivot/Camera3D/CanvasLayer.visible == false:
			$TwistPivot/PitchPivot/Camera3D/CanvasLayer.visible = true
	if Input.is_action_just_pressed("C"):
		if $TwistPivot/PitchPivot/Camera3D/CanvasLayer/Label.visible == true:
			$TwistPivot/PitchPivot/Camera3D/CanvasLayer.visible = false
	
	if global.obj_is_pickuped == true:
		pass
	
	if global.is_sitting == true:
		moveble = false
		$CollisionShape3D.disabled = true
	else:
		moveble = true
		$CollisionShape3D.disabled = false
	
	


@warning_ignore("unused_parameter")
func _on_view_animation_finished(anim_name: StringName) -> void:
	if vw == 1:
		vw = 3
	else:
		vw = 1


func _on_touch_body_entered(body: prop) -> void:
	$"hue-shift".play("hue")



func _on_touch_body_exited(body: prop) -> void:
	$"hue-shift".play_backwards("hue")


func _on_interactable_prop_onk_equipknife_2() -> void:
	$TwistPivot/PitchPivot/arm_base/Node3D/Node3D2.visible = true
	Global.obj_punchable = true


func _on_interactable_prop_onk_2_equipknife_2() -> void:
	$TwistPivot/PitchPivot/arm_base/Node3D/Node3D2_2.visible = true
	Global.obj_superpunchable = true
#
#func _hit():
#	apply_force(Global.playtrans.basis.z * 9000)
#	pass
#
#func instcan(pos, rot):
#	var can_instance = can.instantiate()
#	can_instance.position = pos
#	can_instance.rotation = rot
#	add_child(can_instance)
#
#func insttable(pos, rot):
#	var table_instance = table.instantiate()
#	table_instance.position = pos
#	table_instance.rotation = rot
#	add_child(table_instance)
#
#func instpeaceguy(pos, rot):
#	var bean_instance = bean.instantiate()
#	bean_instance.position = pos
#	bean_instance.rotation = rot
#	add_child(bean_instance)
##
##func instcar(pos, rot):
##	var car_instance = car.instantiate()
##	car_instance.position = pos
##	car_instance.rotation = rot
##	add_child(car_instance)
##
##func instflash(pos, rot):
##	var flash_instance = flashbang.instantiate()
##	flash_instance.position = pos
##	flash_instance.rotation = rot
##	add_child(flash_instance)
##
##func instchair(pos, rot):
##	var chair_instance = chair.instantiate()
##	chair_instance.position = pos
##	chair_instance.rotation = rot
##	add_child(chair_instance)
#
#func _on_button_pressed() -> void:
#	#instcan(Global.obj_pickup_position, Global.obj_pickup_rotation)
#
#func _on_table_pressed() -> void:
#	#insttable(Global.obj_pickup_position, Global.obj_pickup_rotation)
#
#
#func _on_bean_pressed() -> void:
#	#instpeaceguy(Global.obj_pickup_position, Global.obj_pickup_rotation)
#
#
#func _on_carbut_pressed() -> void:
#	#instcar(Global.obj_pickup_position, Global.obj_pickup_rotation)
#
#
#func _on_teleport_pressed() -> void:
#	emit_signal("telespawn")
#
#
#func _on_teleport_2_pressed() -> void:
#	emit_signal("waltuhded")
#
#
#func _on_flashbang_pressed() -> void:
#	#instflash(Global.obj_pickup_position, Global.obj_pickup_rotation)


func _on_body_pressed() -> void:
	$TwistPivot/skeleton/torso.visible = true
	$TwistPivot/MeshInstance3D.visible = false


func _on_playerbean_pressed() -> void:
	$TwistPivot/skeleton/torso.visible = false
	$TwistPivot/MeshInstance3D.visible = true


#func _on_carbut_2_pressed() -> void:
	#instchair(Global.obj_pickup_position, Global.obj_pickup_rotation)
