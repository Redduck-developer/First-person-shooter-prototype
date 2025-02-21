extends Control

var path = str("res://Scenes/Levels/main_menu.tscn")

func _on_button_pressed() -> void:
	$Button.hide()
	$LOADING_MANAGER._load_level(path)
