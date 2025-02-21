extends Node3D

@export var path = str("res://Scenes/Levels/main_menu.tscn")


func _process(delta: float) -> void:
	$testing_loading.path = path
