extends Node3D
func _ready() -> void:
	global.current_enemy_amount = 0




func _on_starting_area_body_entered(body: player) -> void:
	$starting_area.queue_free()
	$StaticBody3D/door_perma_closed.disabled = false
	$StaticBody3D/door_perma_closed.visible = true
	$props/Door.queue_free()
	$wave_spawner._start()
	$Music.play()
