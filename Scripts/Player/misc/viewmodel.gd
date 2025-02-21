extends Node3D
class_name VIEWMODEL

const BOB_FREQ = 2
const BOB_AMP = 0.06
var t_bob = 0.0

func _process(delta: float) -> void:
	if SlotBase.current_slot_data == null:
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = false
	if SlotBase.current_slot_data == "pistol":
		$Pistol.visible = true
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = false
	if SlotBase.current_slot_data == "rifle":
		$Pistol.visible = false
		$AK.visible = true
		$Axe.visible = false
		$KEY.visible = false
	if SlotBase.current_slot_data == "axe":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = true
		$KEY.visible = false
	if SlotBase.current_slot_data == "key":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = true
	
	
	if SlotBase.switched == true:
		$VIEWMODEL_ANIMATION/Swap_animation.stop()
		$VIEWMODEL_ANIMATION/Swap_animation.play("Switch")
		SlotBase.switched = false
	
	
	_aim_down()
	_fire()

func _on_ammo_manager_reload_anim() -> void:
	if SlotBase.current_slot_data == "pistol":
		$VIEWMODEL_ANIMATION/Reload_animations.play("Pistol_reload")
	if SlotBase.current_slot_data == "rifle":
		$VIEWMODEL_ANIMATION/Reload_animations.play("AK_reload")


func _fire():
	if SlotBase.current_slot_data == "pistol":
		if AmmoManager.ammo_left_in_mag > 0:
			if Input.is_action_just_pressed("lmb"):
				$VIEWMODEL_ANIMATION/AnimationPlayer.play("pistol_shoot")
	if SlotBase.current_slot_data == "rifle":
		if AmmoManager.ammo_left_in_mag > 0:
			if AmmoManager.is_ready_to_be_fired == false:
				if Input.is_action_pressed("lmb"):
					$VIEWMODEL_ANIMATION/AnimationPlayer.play("AK_shoot")
	if SlotBase.current_slot_data == "axe":
		if AmmoManager.is_ready_to_be_fired == false:
			if Input.is_action_pressed("lmb"):
				$VIEWMODEL_ANIMATION/AnimationPlayer.play("Axe_Swing")
func _aim_down():
	if Input.is_action_just_pressed("rmb"):
		$VIEWMODEL_ANIMATION/Aim_down_Sights.play("Aimdown")
	elif Input.is_action_just_released("rmb"):
		$VIEWMODEL_ANIMATION/Aim_down_Sights.play_backwards("Aimdown")




# x-0.076 y0.025 z0.055
#


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "AK_shoot":
		AmmoManager.is_ready_to_be_fired = true
	AmmoManager.is_ready_to_be_fired = true
	AmmoManager.is_ready_to_be_fired = true


func _on_reload_animations_animation_finished(anim_name: StringName) -> void:
	AmmoManager._reloaded()
