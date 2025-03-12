extends Node3D






func _on_animation_start_body_entered(body: player) -> void:
	$Props/ANIMATION_START/CollisionShape3D.queue_free()
	$Helper/AnimationPlayer.play("Jump down")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Jump down":
		$Props/Axe
		$Player/Head/Camera3D/PLAYERSLOTS/PLAYERSLOTS_SCROLLING/Slots/startup.play("startup")
		$Player/Head/Camera3D/show_status.play("startup")


func _on_area_3d_body_entered(body: player) -> void:
	SlotBase._delete_all_slot_data()
	AmmoManager._delete_ammo()
	$CanvasLayer/AnimationPlayer.play("fade_in")


func _on_animation_player_animation_finished_end(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().change_scene_to_file("res://Scenes/Levels/NEW_main_menu.tscn")
