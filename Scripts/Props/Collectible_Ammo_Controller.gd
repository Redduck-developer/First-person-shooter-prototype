extends prop
class_name collectible_ammo_manager

@export var is_light_ammo = true
@export var is_medium_ammo = false
@export var is_heavy_ammo = false
@export var collected_ammo_amount = 10
@export var delete_on_collect = true

func _collect():
	visible = false
	$hurtbox.queue_free()
	$Collect_sound.play(0)
	
	if is_light_ammo == true:
		AmmoManager.light_ammo = AmmoManager.light_ammo + collected_ammo_amount
	if is_medium_ammo == true:
		AmmoManager.medium_ammo = AmmoManager.medium_ammo + collected_ammo_amount
	if is_heavy_ammo == true:
		AmmoManager.heavy_ammo = AmmoManager.heavy_ammo + collected_ammo_amount
	
	print("collected")


func _on_collect_sound_finished() -> void:
	if delete_on_collect == true:
		queue_free()
