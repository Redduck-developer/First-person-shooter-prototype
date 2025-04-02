extends Node3D

var wave : int = 0
var enemy_amount : int = 1
var enemy_amount_spawn_needed : int = 0
var enemy_type_1 : PackedScene = preload("res://Scenes/enemies/enemy_mele.tscn")
var ready_to_run_process : bool = false

@export var spin_on_specified_wave : bool = false
@export var specified_wave : int = 5
@export var use_enemy_type_1 : bool = true

func _process(delta: float) -> void:
	$"visual/wave count".text = str(wave)
	$"visual/enemies count".text = str(global.current_enemy_amount)
	if spin_on_specified_wave == false:
		self.rotate_y(0.5)
	else:
		if wave > (specified_wave - 1):
			self.rotate_y(0.5)
	if ready_to_run_process == true:
		if global.current_enemy_amount < 1:
			if enemy_amount_spawn_needed < 1:
				_next_wave()

func _next_wave():
	wave = wave + 1
	enemy_amount = enemy_amount + 2
	enemy_amount_spawn_needed = enemy_amount
	_spawn_enemys($enemy_spawner.global_position)


func _spawn_enemys(pos):
	var instance_enemy_type_1 = enemy_type_1.instantiate()
	if enemy_amount_spawn_needed > 0:
		if use_enemy_type_1 == true:
			instance_enemy_type_1.global_position = pos
			instance_enemy_type_1.needs_sight = false
			instance_enemy_type_1.top_level = true
			instance_enemy_type_1.give_ammo_on_death = true
			enemy_amount_spawn_needed = enemy_amount_spawn_needed - 1
			add_child(instance_enemy_type_1)

func _ready() -> void:
	$Timer.start()

func _start():
	ready_to_run_process = true

func _on_spawn_timeout() -> void:
	if enemy_amount_spawn_needed > 0:
		_spawn_enemys($enemy_spawner.global_position)
		enemy_amount_spawn_needed = enemy_amount_spawn_needed - 1
