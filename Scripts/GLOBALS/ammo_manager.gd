extends Node
class_name AMMO_MANAGER

var light_ammo = 0
var medium_ammo = 0
var heavy_ammo = 0

var mag_size = 0
var ammo_left_in_mag = 0
var switched = true
var is_ready_to_be_fired = true
var empty = 0

signal shoot_anim
signal fire_anim
signal reload_anim
signal WORKPLEASEDEARGOD

func _process(delta: float) -> void:
	if SlotBase.current_slot_data == null:
		return
	
	
	if SlotBase.current_slot_data == "pistol":
		mag_size = 10
		if switched == true:
			ammo_left_in_mag = 0
			switched = false
		if ammo_left_in_mag > 0:
			if Input.is_action_just_pressed("lmb"):
				if is_ready_to_be_fired == true:
					print("SHOOT")
		elif ammo_left_in_mag < 1:
			if Input.is_action_just_pressed("R"):
				emit_signal("reload_anim")
	
	
	if SlotBase.current_slot_data == "rifle":
		mag_size = 30
		if switched == true:
			ammo_left_in_mag = 0
			switched = false
		if ammo_left_in_mag > 0:
			if Input.is_action_pressed("lmb"):
				if is_ready_to_be_fired == true:
					print("SHOOT")
					is_ready_to_be_fired = false
		elif ammo_left_in_mag < 1:
			if Input.is_action_just_pressed("R"):
				emit_signal("reload_anim")
	
	if SlotBase.current_slot_data == "shotgun":
		mag_size = 6
		if switched == true:
			ammo_left_in_mag = 0
			switched = false
		if ammo_left_in_mag > 0:
			if Input.is_action_pressed("lmb"):
				if is_ready_to_be_fired == true:
					print("SHOOT")
					is_ready_to_be_fired = false
		elif ammo_left_in_mag < 1:
			if Input.is_action_just_pressed("R"):
				emit_signal("reload_anim")
	
	if SlotBase.current_slot_data == "axe":
		mag_size = 0
		if switched == true:
			ammo_left_in_mag = 0
			switched = false
		if Input.is_action_pressed("lmb"):
			if is_ready_to_be_fired == true:
				print("SHOOT")
				is_ready_to_be_fired = false


func _reloaded():
	if SlotBase.current_slot_data == "pistol":
		if not light_ammo - mag_size < 0:
			light_ammo = light_ammo - mag_size
			ammo_left_in_mag = 10
			print(mag_size)
			print(ammo_left_in_mag)
	
	
	if SlotBase.current_slot_data == "rifle":
		if not medium_ammo - mag_size < 0:
			medium_ammo = medium_ammo - mag_size
			ammo_left_in_mag = 30
			print(mag_size)
			print(ammo_left_in_mag)
	
	if SlotBase.current_slot_data == "shotgun":
		if not heavy_ammo - mag_size < 0:
			heavy_ammo = heavy_ammo - mag_size
			ammo_left_in_mag = 6
			print(mag_size)
			print(ammo_left_in_mag)

func _delete_ammo():
	light_ammo = 0
	medium_ammo = 0
	heavy_ammo = 0
	ammo_left_in_mag = 0
