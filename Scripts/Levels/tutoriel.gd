extends Node3D

var mm = preload("res://Scenes/Levels/main_menu.tscn")
signal load

func _on_area_3d_2_body_entered(body: player) -> void:
	$Player.MOVEABLE = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Complete_card.visible = true
	


func _on_button_pressed() -> void:
	pass


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_packed(mm)
	global.sleepy_eepy = true #honk mimimimi
	AmmoManager._delete_ammo()
	SlotBase._delete_all_slot_data()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_button_3_pressed() -> void:
	get_tree().quit()
