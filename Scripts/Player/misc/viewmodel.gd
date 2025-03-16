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
		$Flashlight.visible = false
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "pistol":
		$Pistol.visible = true
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = false
		$Flashlight.visible = false
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "rifle":
		$Pistol.visible = false
		$AK.visible = true
		$Axe.visible = false
		$KEY.visible = false
		$Flashlight.visible = false
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "axe":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = true
		$KEY.visible = false
		$Flashlight.visible = false
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "key":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = true
		$Flashlight.visible = false
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "flashlight":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = false
		$Flashlight.visible = true
		$NEW_shotgun.visible = false
	if SlotBase.current_slot_data == "shotgun":
		$Pistol.visible = false
		$AK.visible = false
		$Axe.visible = false
		$KEY.visible = false
		$Flashlight.visible = false
		$NEW_shotgun.visible = true
	
	
	if SlotBase.switched == true:
		$VIEWMODEL_ANIMATION/Swap_animation.stop()
		$VIEWMODEL_ANIMATION/Swap_animation.play("Switch")
		SlotBase.switched = false
	
	if Input.is_action_just_pressed("G"):
		$VIEWMODEL_ANIMATION/Kicking_animation.play("kick")
	
	
	_aim_down()
	_fire()

func _on_ammo_manager_reload_anim() -> void:
	if SlotBase.current_slot_data == "pistol":
		$VIEWMODEL_ANIMATION/Reload_animations.play("Pistol_reload")
	if SlotBase.current_slot_data == "rifle":
		$VIEWMODEL_ANIMATION/Reload_animations.play("AK_reload")
	if SlotBase.current_slot_data == "shotgun":
		$VIEWMODEL_ANIMATION/Reload_animations.play("shotgun_reload")

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
	if SlotBase.current_slot_data == "shotgun":
		if AmmoManager.ammo_left_in_mag > 0:
			if AmmoManager.is_ready_to_be_fired == false:
				if Input.is_action_pressed("lmb"):
					$VIEWMODEL_ANIMATION/AnimationPlayer.play("Shotgun_shoot")
func _aim_down():
	if Input.is_action_just_pressed("rmb"):
		$VIEWMODEL_ANIMATION/Aim_down_Sights.play("Aimdown")
		get_parent().get_parent().get_parent().BASE_FOV = get_parent().get_parent().get_parent().ZOOM_FOV
	elif Input.is_action_just_released("rmb"):
		$VIEWMODEL_ANIMATION/Aim_down_Sights.play_backwards("Aimdown")
		get_parent().get_parent().get_parent().BASE_FOV = get_parent().get_parent().get_parent().NORMAL_FOV




# x-0.076 y0.025 z0.055
#


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not SlotBase.current_slot_data == "axe":
		AmmoManager.is_ready_to_be_fired = true
		AmmoManager.ammo_left_in_mag = AmmoManager.ammo_left_in_mag - 1


func _on_reload_animations_animation_finished(anim_name: StringName) -> void:
	AmmoManager._reloaded()
