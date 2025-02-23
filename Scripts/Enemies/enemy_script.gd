extends CharacterBody3D
class_name enemy

@onready var nav = $NavigationAgent3D

@export var AXE : bool = true
@export var Health : int = 100

var SPEED = 3.5
var SPRINT_SPEED = 8.0
var WALK_SPEED = 3.0
var gravity = 9.8
var in_sight = false
var spotted = false
const JUMP_VELOCITY = 6


func _physics_process(delta: float) -> void:
	$MeshInstance3D/ARMS.rotation.y = $MeshInstance3D/head.rotation.y
	$MeshInstance3D/LEGS.rotation.y = $MeshInstance3D/head.rotation.y
	
	if Health < 1:
		$death_animation.play("death")
		axis_lock_linear_x = true
		axis_lock_linear_z = true
	
	if AXE == true:
		$MeshInstance3D/ARMS/arms/Axe.visible = true
	else:
		$MeshInstance3D/ARMS/arms/Axe.visible = false
	
	var current_position = global_transform.origin
	var next_position = nav.get_next_path_position()
	var new_velocity = (next_position - current_position).normalized() * SPEED
	$RayCast3D.rotate_y(1)
	if in_sight == true:
		$MeshInstance3D/head.look_at(global.headpos)
		
		if %SEE_CAST.is_colliding():
			spotted = true
		else:
			spotted = false
		
		if spotted == true:
			$"Walking(concrete)".playing = true
			$"Walking(concrete)".volume_db = 80
			$walk_run_animation_player.play("move")
			update_target_location(null)
			
			if not is_on_floor():
				velocity.y -= (gravity * 2) * delta
			if $RayCast3D.is_colliding():
				if is_on_floor():
					if $RayCast3D.get_collider() is not player:
						if $RayCast3D.get_collider() is not prop:
							if $RayCast3D.get_collider() is not enemy:
								velocity.y = JUMP_VELOCITY
			
			if %SPRINT_CAST.is_colliding():
				if $%SPRINT_CAST.get_collider() is player:
					SPEED = WALK_SPEED
					$walk_run_animation_player.speed_scale = 2.5
					$"Walking(concrete)".pitch_scale = 1
			else:
				SPEED = SPRINT_SPEED
				$walk_run_animation_player.speed_scale = 5
				$"Walking(concrete)".pitch_scale = 2
			
			if %HURT_CAST.is_colliding():
				if %HURT_CAST.get_collider() is player:
					$Attack_Animation_player.play("attack_axe")
			
			
			velocity.x = new_velocity.x
			velocity.z = new_velocity.z
			_push_away_rigid_bodies()
			move_and_slide()
		else:
			$walk_run_animation_player.stop()
			$"Walking(concrete)".volume_db = -80
			$"Walking(concrete)".playing = false
	else:
		pass


func update_target_location(target_location):
	nav.target_position = global.playpos

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


func _on_vision_body_entered(body: Node3D) -> void:
	if body is player:
		in_sight = true


func _on_vision_body_exited(body: Node3D) -> void:
	if body is player:
		in_sight = false


func _on_attack_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_axe":
		$Attack_Animation_player.play("reset_axe")
		if %HURT_CAST.is_colliding():
			if %HURT_CAST.get_collider() is player:
				StatusManager._hurt(10)


func  _hurt(amount):
	Health = Health - amount
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true
	$MeshInstance3D/head.look_at(global.headpos)
	$HitSound.stop()
	$HitSound.play()


func _on_death_animation_animation_finished(anim_name: StringName) -> void:
	$death_animation.stop()
	queue_free()


func _on_hurtbox_area_entered(area: Area3D) -> void:
	if area is light_bullet:
		_hurt(10)
	if area is Medium_bullet:
		_hurt(15)
