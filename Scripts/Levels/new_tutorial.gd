extends Node3D






func _on_animation_start_body_entered(body: player) -> void:
	$ANIMATION_START/CollisionShape3D.queue_free()
	$Helper/AnimationPlayer.play("Jump down")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Jump down":
		$Props/Axe
		$Player/Head/Camera3D/PLAYERSLOTS/PLAYERSLOTS_SCROLLING/Slots/startup.play("startup")
		$Player/Head/Camera3D/show_status.play("startup")
