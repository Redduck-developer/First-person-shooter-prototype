extends CanvasLayer


func _physics_process(delta: float) -> void:
	if StatusManager.Health == 0:
		$Death_Screen.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if StatusManager.Show_Stats == true:
		$HealthTexture/Health_indicator2.visible = true
		$HealthTexture/Stamina_indicator.visible = true
	else:
		$HealthTexture/Health_indicator2.visible = false
		$HealthTexture/Stamina_indicator.visible = false
	
	
	$HealthTexture/Health_indicator2.text = str(StatusManager.Health)
	$HealthTexture/Stamina_indicator.text = str(StatusManager.stamina)
	$HealthTexture/Staminabar.value = StatusManager.stamina
	$HealthTexture/Healthbar.value = StatusManager.Health
	
	if Input.is_action_just_pressed("TAB"):
		$SWITCH_ANIMATION_PLAYER.play("Switched")
	
	
	if StatusManager.HURT_ANIM == true:
		$Hurt_animation.stop()
		$Hurt_animation.play("HURT")
		StatusManager.HURT_ANIM = false
	
	
	if StatusManager.Health == 100:
		$HealthTexture/Health_indicator.text = str("HEALTHY")
	if StatusManager.Health > 25:
		if not StatusManager.Health == 100:
			$HealthTexture/Health_indicator.text = str("HURT")
	if StatusManager.Health < 26:
		$HealthTexture/Health_indicator.text = str("CRITICAL")
	if StatusManager.Health == 1:
		$HealthTexture/Health_indicator.text = str("CRITICAL")
	if StatusManager.Health < 1:
		$HealthTexture/Health_indicator.text = str("DECEASED")
	
	
	if StatusManager.depleted == true:
		$HealthTexture/Stamina_indicator2.text = "TIRED"
	else:
		$HealthTexture/Stamina_indicator2.text = " "
	
	
func _switch_visibility():
	$HealthTexture.visible = !$HealthTexture.visible
	get_parent().get_parent().get_node("AMMO_MANAGER/AMMO_VISUALIZER/AmmoTexture").visible = !get_parent().get_parent().get_node("AMMO_MANAGER/AMMO_VISUALIZER/AmmoTexture").visible
