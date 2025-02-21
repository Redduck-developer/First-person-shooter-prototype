extends Node3D
class_name Trampoline

@export var jump_height = 0

func _on_body_entered(body: player) -> void:
	global.jump = jump_height
