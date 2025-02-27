extends Node

#Health vars
var Health = 100
var HURT_ANIM = false

#Stamina vars
var stamina : float = 100   #FULL = 10 / EMPTY = 0
var stamina_loss : float = 1
var using_stamina : bool = false
var depleted : bool = false

#Status/Visibility vars
var Show_Stats = false

func _process(delta: float) -> void:
	var IS_MOVING = Input.get_vector("a","d","w","s")
	
	if Health > 100:
		Health = 100
	if Health < 0:
		Health = 0
	
	#STAMINA
	if using_stamina == true:
		if depleted == false:
			if IS_MOVING:
				stamina = stamina - stamina_loss
			else:
				stamina = stamina + stamina_loss
		elif depleted == true:
			stamina = stamina + stamina_loss
	else:
		stamina = stamina + stamina_loss
	
	if stamina == 0:
		if depleted == false:
			depleted = true
	if stamina == 100:
		if depleted == true:
			depleted = false
	
	if stamina > 100:
		stamina = 100
	if stamina < 0:
		stamina = 0
	
	if Input.is_action_just_pressed("SHIFT"):
		using_stamina = true
	elif Input.is_action_just_released("SHIFT"):
		using_stamina = false
	

func _hurt(amount : int):
	Health = Health - amount
	HURT_ANIM = true

func _heal(amount : int, REPLACE_OR_ADD : bool):
	if REPLACE_OR_ADD == true:
		Health = amount
	if REPLACE_OR_ADD == false:
		Health = Health + amount
