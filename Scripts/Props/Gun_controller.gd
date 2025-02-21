extends prop
class_name gun_manager

@export var ID = ""
@export var delete_on_collect = false
@export var give_ammo_on_pickup = false
@export var given_ammo = 0

signal collected

func _collect():
	if SlotBase.current_slot_data == null:
		visible = false
		$hurtbox.queue_free()
		$Collect_sound.play(0)
		SlotBase._set_ID(ID)
		print("collected")
		emit_signal("collected")
		if give_ammo_on_pickup == true:
			AmmoManager.light_ammo = AmmoManager.light_ammo + given_ammo


func _on_collect_sound_finished() -> void:
	if delete_on_collect == true:
		queue_free()
