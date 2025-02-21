extends Node



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		$pause.visible = true
		get_tree().paused = true
	
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
	get_tree().quit()
