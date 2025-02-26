extends Node

var disabled = false
var light_ammo_add = 0
var medium_ammo_add = 0
var heavy_ammo_add = 0


func _ready() -> void:
	$"pause/Control/Debug_container/OS INFO/CPU".text = str(OS.get_processor_name())
	$"pause/Control/Debug_container/OS INFO/GPU".text = str(RenderingServer.get_rendering_device().get_device_name())
	$"pause/Control/Debug_container/OS INFO/OS".text = str(OS.get_name())


func _process(_delta: float) -> void:
	if get_parent().get_parent().get_parent().dev_mode == true:
		$"CPU FRAME DELAY".visible = true
	else:
		$"CPU FRAME DELAY".visible = false
	$"CPU FRAME DELAY".text = str(RenderingServer.get_frame_setup_time_cpu())
	
	
	if disabled == false:
		if Input.is_action_just_pressed("ESC"):
			$pause.visible = true
			get_tree().paused = true
	
	if get_parent().get_parent().get_parent().dev_mode == true:
		$pause/Control/VBoxContainer/Button5.visible = true
	elif get_parent().get_parent().get_parent().dev_mode == false:
		$pause/Control/VBoxContainer/Button5.visible = false
	
	
	$pause/Control/Debug_container/Node2D/AMMO/Light_ammo_count.text = str(light_ammo_add)
	$pause/Control/Debug_container/Node2D/AMMO/Medium_ammo_count.text = str(medium_ammo_add)
	$pause/Control/Debug_container/Node2D/AMMO/Heavy_ammo_count.text = str(heavy_ammo_add)
	
	get_parent().get_parent().get_parent().SENSITIVITY = $"pause/Control/Settings_container/Sensitivity Slider".value


func _on_button_pressed() -> void:
	print("clicked1")
	$pause.visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("clicked2")


func _on_button_2_pressed() -> void:
	print("clicked")
	$pause/Control/Settings_container.visible = !$pause/Control/Settings_container.visible


func _on_button_3_pressed() -> void:
	global.sleepy_eepy = true #honk mimimimi
	AmmoManager._delete_ammo()
	SlotBase._delete_all_slot_data()
	$pause.visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file("res://Scenes/Levels/NEW_main_menu.tscn")


func _on_button_4_pressed() -> void:
	get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_id_1_pressed() -> void:
	SlotBase.ID_ONE = $pause/Control/Debug_container/Node2D/TextEdit.text
	SlotBase.ID_ONE_FULL = true



func _on_id_2_pressed() -> void:
	SlotBase.ID_TWO = $pause/Control/Debug_container/Node2D/TextEdit2.text
	SlotBase.ID_TWO_FULL = true 


func _on_id_3_pressed() -> void:
	SlotBase.ID_THREE = $pause/Control/Debug_container/Node2D/TextEdit3.text
	SlotBase.ID_THREE_FULL = true 


func _on_id_4_pressed() -> void:
	SlotBase.ID_FOUR = $pause/Control/Debug_container/Node2D/TextEdit4.text
	SlotBase.ID_FOUR_FULL = true 


func _on_clear_i_ds_pressed() -> void:
	SlotBase._safe_delete_all_slot_data()


func _on_light_pressed() -> void:
	AmmoManager.light_ammo = AmmoManager.light_ammo + light_ammo_add


func _on_add_l_pressed() -> void:
	light_ammo_add = light_ammo_add + 1


func _on_subtract_l_pressed() -> void:
	light_ammo_add = light_ammo_add - 1


func _on_add_m_pressed() -> void:
	medium_ammo_add = medium_ammo_add + 1


func _on_subtract_m_pressed() -> void:
	medium_ammo_add = medium_ammo_add - 1


func _on_add_h_pressed() -> void:
	heavy_ammo_add = heavy_ammo_add + 1


func _on_subtract_h_pressed() -> void:
	heavy_ammo_add = heavy_ammo_add - 1


func _on_medium_pressed() -> void:
	AmmoManager.medium_ammo = AmmoManager.medium_ammo + medium_ammo_add


func _on_heavy_pressed() -> void:
	AmmoManager.heavy_ammo = AmmoManager.heavy_ammo + heavy_ammo_add


func _on_PC_button_pressed() -> void:
	DisplayServer


func _on_ssn_pressed() -> void:
	StatusManager.Show_Stats = true


func _on_hsn_pressed() -> void:
	StatusManager.Show_Stats = false


func _on_button_5_pressed() -> void:
	$pause/Control/Debug_container.visible = !$pause/Control/Debug_container.visible
