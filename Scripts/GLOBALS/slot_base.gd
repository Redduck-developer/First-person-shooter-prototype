extends Node
class_name PLAYERSLOTS

#CURRENT SLOT & AMOUNT OF SLOTS
var Current_slot_selected = 1
var Slot_numb = 4

#SLOT DATA
var current_slot_data = null

#ID'S & ID COMPONENTS
var ID_ONE = null
var ID_ONE_FULL = false
var ID_TWO = null
var ID_TWO_FULL = false
var ID_THREE = null
var ID_THREE_FULL = false
var ID_FOUR =  null
var ID_FOUR_FULL = false
var ID_FIVE =  null
var ID_Five_FULL = false
var ID_SIX = null

#WEAPON SCENES
var pistol = preload("res://Scenes/props/Collectibles (NOT AMMO)/gun_pistol.tscn")
var AK = preload("res://Scenes/props/Collectibles (NOT AMMO)/gun_rifle.tscn")
var AXE = preload("res://Scenes/props/Collectibles (NOT AMMO)/Axe_collect.tscn")
var KEY = preload("res://Scenes/props/Collectibles (NOT AMMO)/key.tscn")
var flash = preload("res://Scenes/props/Collectibles (NOT AMMO)/flashlight.tscn")
var shotgun = preload("res://Scenes/props/Collectibles (NOT AMMO)/gun_shotgun.tscn")

#MISC
var switched = false
var KILL = false

func _set_ID(id):
	if Current_slot_selected == 1:
		if ID_ONE_FULL == false:
			ID_ONE = id
			ID_ONE_FULL = true
		else:
			printerr("FAILED")
	if Current_slot_selected == 2:
		if ID_TWO_FULL == false:
			ID_TWO = id
			ID_TWO_FULL = true
		else:
			printerr("FAILED")
	if Current_slot_selected == 3:
		if ID_THREE_FULL == false:
			ID_THREE = id
			ID_THREE_FULL = true
		else:
			printerr("FAILED")
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == false:
			ID_FOUR = id
			ID_FOUR_FULL = true
		else:
			printerr("FAILED")

func _remove_ID():
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "pistol":
				instpistol(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "pistol":
				instpistol(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "pistol":
				instpistol(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "pistol":
				instpistol(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE
	
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "rifle":
				instAK(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "rifle":
				instAK(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "rifle":
				instAK(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "rifle":
				instAK(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE
	
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "axe":
				instaxe(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "axe":
				instaxe(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "axe":
				instaxe(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "axe":
				instaxe(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE
	
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "key":
				instKEY(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "key":
				instKEY(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "key":
				instKEY(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "key":
				instKEY(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE
	
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "flashlight":
				instFLASH(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "flashlight":
				instFLASH(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "flashlight":
				instFLASH(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "flashlight":
				instFLASH(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE
	
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			if ID_ONE == "shotgun":
				instshotgun(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_ONE_FULL = false
				ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			if ID_TWO == "shotgun":
				instshotgun(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_TWO_FULL = false
				ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			if ID_THREE == "shotgun":
				instshotgun(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_THREE_FULL = false
				ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			if ID_FOUR == "shotgun":
				instshotgun(global.obj_pickup_position,global.obj_pickup_rotation)
				ID_FOUR_FULL = false
				ID_FOUR = ID_FIVE


func _remove_id_instantiantionless():
	if Current_slot_selected == 1:
		if ID_ONE_FULL == true:
			ID_ONE_FULL = false
			ID_ONE = ID_FIVE
	if Current_slot_selected == 2:
		if ID_TWO_FULL == true:
			ID_TWO_FULL = false
			ID_TWO = ID_FIVE
	if Current_slot_selected == 3:
		if ID_THREE_FULL == true:
			ID_THREE_FULL = false
			ID_THREE = ID_FIVE
	if Current_slot_selected == 4:
		if ID_FOUR_FULL == true:
			ID_FOUR_FULL = false
			ID_FOUR = ID_FIVE


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		print(Current_slot_selected)
	if Input.is_action_just_pressed("Q"):
		_remove_ID()
		print("removed")

	
	if Current_slot_selected == 1:
		current_slot_data = ID_ONE
	if Current_slot_selected == 2:
		current_slot_data = ID_TWO
	if Current_slot_selected == 3:
		current_slot_data = ID_THREE
	if Current_slot_selected == 4:
		current_slot_data = ID_FOUR

func _delete_all_slot_data():
	ID_ONE = ID_FIVE
	ID_TWO = ID_FIVE
	ID_THREE = ID_FIVE
	ID_FOUR = ID_FIVE
	ID_ONE_FULL = false
	ID_TWO_FULL = false
	ID_THREE_FULL = false
	ID_FOUR_FULL = false
	KILL = true


func _safe_delete_all_slot_data():
	ID_ONE = ID_FIVE
	ID_TWO = ID_FIVE
	ID_THREE = ID_FIVE
	ID_FOUR = ID_FIVE
	ID_ONE_FULL = false
	ID_TWO_FULL = false
	ID_THREE_FULL = false
	ID_FOUR_FULL = false


#Instantiation functions beyond this point

func instpistol(pos, rot):
	var pistol_instance = pistol.instantiate()
	pistol_instance.position = pos
	pistol_instance.rotation = rot
	add_child(pistol_instance)

func instAK(pos, rot):
	var AK_instance = AK.instantiate()
	AK_instance.position = pos
	AK_instance.rotation = rot
	add_child(AK_instance)

func instaxe(pos, rot):
	var AXE_instance = AXE.instantiate()
	AXE_instance.position = pos
	AXE_instance.rotation = rot
	add_child(AXE_instance)

func instKEY(pos, rot):
	var instance = KEY.instantiate()
	instance.position = pos
	instance.rotation = rot
	add_child(instance)

func instFLASH(pos, rot):
	var instance = flash.instantiate()
	instance.position = pos
	instance.rotation = rot
	add_child(instance)

func instshotgun(pos, rot):
	var instance = shotgun.instantiate()
	instance.position = pos
	instance.rotation = rot
	add_child(instance)

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
