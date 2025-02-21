extends Node3D
class_name prop

var is_pickupable = false
var is_pickuped = false
var blood = preload("res://Scenes/misc/blood_decal.tscn")
@export var health = 3
@export var is_super_pickupable = true
@export var is_breakable = false
@export var rotate_with_player = true
@export var is_RigidBody3D = false
@export var does_bleed = false
@export var hit_particle = false
@export var mele_hit_partical = false


signal HIT

func _physics_process(_delta: float) -> void:
	if is_super_pickupable == true:
		if is_pickupable == true:
			if Input.is_action_just_pressed("E"):
				is_pickuped = !is_pickuped
				global.obj_is_pickuped = !global.obj_is_pickuped
			if Input.is_action_just_pressed("F"):
				_collect()
	
	if is_pickuped == true:
		position = global.obj_pickup_position
		$CollisionShape3D.disabled = true
		if is_RigidBody3D == true:
			self.freeze = true
		if rotate_with_player == true:
			rotation = global.obj_pickup_rotation
	else:
		$CollisionShape3D.disabled = false
		if is_RigidBody3D == true:
			self.freeze = false
	
	if get_parent() == SlotBase:
		if get_parent().KILL == true:
			queue_free()
	
	


func _on_hurtbox_area_entered(area: Area3D) -> void:
	if area is touch:
		is_pickupable = true
	if area is light_bullet:
		if does_bleed == true:
			blood_instantiate(self.position)
		if hit_particle == true:
			$GPUParticles3D.emitting = true
			emit_signal("HIT")
	if area is Medium_bullet:
		if does_bleed == true:
			blood_instantiate(self.position)
		if hit_particle == true:
			$GPUParticles3D.emitting = true
			emit_signal("HIT")



func _on_hurtbox_area_exited(area: Area3D) -> void:
	if area is touch:
		is_pickupable = false

func blood_instantiate(pos):
	var blood_inst = blood.instantiate()
	blood_inst.position = pos
	add_child(blood_inst)

func _break():
	print("hit")
	health = health - 1
	$Mele_hit_particals.emitting = true 
	if health == 0:
		queue_free()


func _on_hurtbox_body_entered(body: Node3D) -> void:
	$Impact.play()


func _collect():
	pass #replace in child script
