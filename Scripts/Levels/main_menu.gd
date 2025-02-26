extends Node3D

var lvl_sbx_GR = load("res://Scenes/Levels/gun_range.tscn")
var player_node = preload("res://Scenes/player.tscn")
@export var is_already_loaded = false


signal load_testsite

func _ready() -> void:
	var player_inst = player_node.instantiate()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is light_bullet:
		emit_signal("load_testsite")
		get_tree().change_scene_to_file("res://Scenes/Levels/testsite.tscn")
		SlotBase._delete_all_slot_data()
		AmmoManager._delete_ammo()
		if global.sleepy_eepy == true:
			queue_free()


func _on_level_module_collected() -> void:
	$Props/Level_module2.queue_free()
	$Level_Sandbox_Testsite.visible = true
	$Level_Sandbox_Testsite/Area3D/CollisionShape3D.disabled = false
	$Level_Sandbox_Gunrange.visible = true
	$Level_Sandbox_Gunrange/Area3D/CollisionShape3D.disabled = false
	$Level_Sandbox_Island.visible = true
	$Level_Sandbox_Island/Area3D/CollisionShape3D.disabled = false


func _on_area_3d_gunrange_area_entered(area: Area3D) -> void:
	var lvl_inst_GR = lvl_sbx_GR.instantiate()
	if area is light_bullet:
		emit_signal("load_testsite")
		get_tree().change_scene_to_file("res://Scenes/Levels/gun_range.tscn")
		SlotBase._delete_all_slot_data()
		AmmoManager._delete_ammo()
		if global.sleepy_eepy == true:
			queue_free()


func _on_area_3d_area_entered_tut(area: Area3D) -> void:
	if area is light_bullet:
		emit_signal("load_testsite")
		get_tree().change_scene_to_file("res://Scenes/Levels/Tutorial.tscn")
		SlotBase._delete_all_slot_data()
		AmmoManager._delete_ammo()
		if global.sleepy_eepy == true:
			queue_free()


func _on_area_3d_area_entered_island(area: Area3D) -> void:
	if area is light_bullet:
		emit_signal("load_testsite")
		get_tree().change_scene_to_file("res://Scenes/Levels/ISLAND.tscn")
		SlotBase._delete_all_slot_data()
		AmmoManager._delete_ammo()
		if global.sleepy_eepy == true:
			queue_free()


func _on_level_module_2_collected() -> void:
	$Props/Level_module.queue_free()
	$Level_Story_Tutorial.visible = true
	$Level_Story_Tutorial/Area3D/CollisionShape3D.disabled = false
