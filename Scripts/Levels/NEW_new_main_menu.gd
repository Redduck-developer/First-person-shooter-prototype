extends Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_back_button_pressed() -> void:
	$ui/title.visible = true
	$ui/gamode.visible = false

func _on_play_button_pressed() -> void:
	$ui/title.visible = false
	$ui/gamode.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_sandbox_button_pressed() -> void:
	$ui/gamode.visible = false
	$ui/sandbox.visible = true

func _on_back_2_button_pressed() -> void:
	$ui/gamode.visible = true
	$ui/sandbox.visible = false

func _on_testsite_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/testsite.tscn")

func _on_gunrange_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/gun_range.tscn")

func _on_island_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ISLAND.tscn")

func _on_oldmainmenu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

func _on_oldtutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Tutorial.tscn")

func _on_settings_button_pressed() -> void:
	$ui/title.visible = false
	$ui/settings.visible = true

func _on_back_3_button_pressed() -> void:
	$ui/title.visible = true
	$ui/settings.visible = false

func _on_story_button_pressed() -> void:
	$ui/gamode.visible = false
	$ui/Story.visible = true

func _on_back_5_button_pressed() -> void:
	$ui/gamode.visible = true
	$ui/Story.visible = false

func _on_new_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/new_tutorial.tscn")

func _on_arena_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/wave_survival.tscn")

func _on_arena_button_pressed() -> void:
	$ui/Arena.visible = true
	$ui/gamode.visible = false

func _on_back_6_button_pressed() -> void:
	$ui/Arena.visible = false
	$ui/gamode.visible = true

#actual functions above
#-------------------------------------------
#outline functions below

func _on_play_button_mouse_entered() -> void:
	$ui/title/PLAY/OUTLINE.visible = true


func _on_play_button_mouse_exited() -> void:
	$ui/title/PLAY/OUTLINE.visible = false


func _on_quit_button_mouse_entered() -> void:
	$ui/title/QUIT/OUTLINE.visible = true


func _on_quit_button_mouse_exited() -> void:
	$ui/title/QUIT/OUTLINE.visible = false


func _on_sandbox_button_mouse_entered() -> void:
	$ui/gamode/SANDBOX/OUTLINE.visible = true


func _on_sandbox_button_mouse_exited() -> void:
	$ui/gamode/SANDBOX/OUTLINE.visible = false


func _on_story_button_mouse_entered() -> void:
	$ui/gamode/STORY/OUTLINE.visible = true


func _on_story_button_mouse_exited() -> void:
	$ui/gamode/STORY/OUTLINE.visible = false


func _on_back_button_mouse_entered() -> void:
	$ui/gamode/BACK/OUTLINE.visible = true


func _on_back_button_mouse_exited() -> void:
	$ui/gamode/BACK/OUTLINE.visible = false


func _on_testsite_button_mouse_entered() -> void:
	$ui/sandbox/TESTSITE/OUTLINE.visible = true


func _on_testsite_button_mouse_exited() -> void:
	$ui/sandbox/TESTSITE/OUTLINE.visible = false


func _on_gunrange_button_mouse_entered() -> void:
	$ui/sandbox/GUNRANGE/OUTLINE.visible = true


func _on_gunrange_button_mouse_exited() -> void:
	$ui/sandbox/GUNRANGE/OUTLINE.visible = false


func _on_island_button_mouse_entered() -> void:
	$ui/sandbox/ISLAND/OUTLINE.visible = true


func _on_island_button_mouse_exited() -> void:
	$ui/sandbox/ISLAND/OUTLINE.visible = false


func _on_oldmainmenu_button_mouse_entered() -> void:
	$ui/sandbox/OLD_MAIN_MENU/OUTLINE.visible = true


func _on_oldmainmenu_button_mouse_exited() -> void:
	$ui/sandbox/OLD_MAIN_MENU/OUTLINE.visible = false


func _on_back_2_button_mouse_entered() -> void:
	$ui/sandbox/BACK/OUTLINE.visible = true


func _on_back_2_button_mouse_exited() -> void:
	$ui/sandbox/BACK/OUTLINE.visible = false


func _on_settings_button_mouse_entered() -> void:
	$ui/title/SETTINGS/OUTLINE.visible = true


func _on_settings_button_mouse_exited() -> void:
	$ui/title/SETTINGS/OUTLINE.visible = false


func _on_back_3_button_mouse_entered() -> void:
	$ui/settings/BACK/OUTLINE.visible = true


func _on_back_3_button_mouse_exited() -> void:
	$ui/settings/BACK/OUTLINE.visible = false


func _on_oldtutorial_button_mouse_entered() -> void:
	$ui/sandbox/OLD_TUTORIAL/OUTLINE.visible = true


func _on_oldtutorial_button_mouse_exited() -> void:
	$ui/sandbox/OLD_TUTORIAL/OUTLINE.visible = false


func _on_back_5_button_mouse_entered() -> void:
	$ui/Story/BACK/OUTLINE.visible = true


func _on_back_5_button_mouse_exited() -> void:
	$ui/Story/BACK/OUTLINE.visible = false


func _on_new_tutorial_mouse_entered() -> void:
	$ui/Story/NEW_Tutorial/OUTLINE.visible = true


func _on_new_tutorial_mouse_exited() -> void:
	$ui/Story/NEW_Tutorial/OUTLINE.visible = false


func _on_arena_1_button_mouse_entered() -> void:
	$ui/Arena/Arena_1/OUTLINE.visible = true


func _on_arena_1_button_mouse_exited() -> void:
	$ui/Arena/Arena_1/OUTLINE.visible = false



func _on_arena_button_mouse_entered() -> void:
	$ui/gamode/ARENA/OUTLINE.visible = true


func _on_arena_button_mouse_exited() -> void:
	$ui/gamode/ARENA/OUTLINE.visible = false



func _on_back_6_button_mouse_entered() -> void:
	$ui/Arena/BACK/OUTLINE.visible = true


func _on_back_6_button_mouse_exited() -> void:
	$ui/Arena/BACK/OUTLINE.visible = true
