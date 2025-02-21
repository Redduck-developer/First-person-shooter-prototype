extends Node3D

var climbing = false
var interactable = false
var wipe = false
@export var is_wipeable = true

func _process(delta: float) -> void:
	if interactable == true:
		if Input.is_action_just_pressed("E"):
			climbing = !climbing
	
	if climbing == true:
		if is_wipeable == true:
			wipe = true
		global.Climbing_Pos = $Path3D/PathFollow3D.global_position
		global.is_climbing = true
		if Input.is_action_pressed("w"):
			$Path3D/PathFollow3D.progress_ratio = $Path3D/PathFollow3D.progress_ratio + 0.005
		if Input.is_action_pressed("s"):
			$Path3D/PathFollow3D.progress_ratio = $Path3D/PathFollow3D.progress_ratio - 0.005
	else:
		global.is_climbing = false
		if wipe == true:
			$Path3D/PathFollow3D.progress_ratio = 0
			global.Climbing_Pos = Vector3(0,0,0)
			wipe = false


func _on_area_3d_area_entered(area: touch) -> void:
	interactable = true


func _on_area_3d_area_exited(area: touch) -> void:
	interactable = false
