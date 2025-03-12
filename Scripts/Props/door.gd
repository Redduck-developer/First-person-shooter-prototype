extends Node3D
class_name door

#vars
var is_interactable = false
var opened = false

#@export vars
@export var health = 5
@export var is_breakable = true
@export var locked = false
@export var double_doors = false

func _process(delta: float) -> void:
	if is_interactable == true:
		if Input.is_action_just_pressed("E") or Input.is_action_just_pressed("G"):
				if locked == false:
					opened = !opened
					_open_close()
		if Input.is_action_just_pressed("lmb"):
			if SlotBase.current_slot_data == "axe":
				if is_breakable == true:
					_break()
	
	if locked == true:
		$DOOR/locks.visible = true
		if double_doors == true:
			$DOOR2/locks.visible = true
		if Input.is_action_just_pressed("E"):
			if SlotBase.current_slot_data == "key":
				if is_interactable:
					SlotBase._remove_id_instantiantionless()
					locked = false
					$Unlock.play(0)
	else:
		$DOOR/locks.visible = false
		if double_doors == true:
			$DOOR2/locks.visible = false

func _open_close():
	if opened == true:
		$AnimationPlayer.play("open")
		$DoorOpenClose.stop()
		$DoorOpenClose.play(0)
	if opened == false:
		$AnimationPlayer.play_backwards("open")
		$DoorOpenClose.stop()
		$DoorOpenClose.play(0)

func _on_hurtbox_area_exited(area: Area3D) -> void:
	if area is touch:
		is_interactable = false


func _on_hurtbox_area_entered(area: Area3D) -> void:
	if area is touch:
		is_interactable = true


func _break():
	print("hit")
	health = health - 1
	$DOOR/Mele_hit_particals.emitting = true 
	if health == 0:
		queue_free()
