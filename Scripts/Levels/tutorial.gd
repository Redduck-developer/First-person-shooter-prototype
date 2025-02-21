extends Node3D




func _on_target_hit() -> void:
	$doorway/AnimationPlayer.play("summon")
	$Props/Target.queue_free()


func _on_area_3d_body_entered(body: player) -> void:
	$Player.position = Vector3(0,0,0)
	$CSG/Tutorial_room/Door.queue_free()
	$doorway.queue_free()
