extends Control

var LOADING : bool
var PATH : String
var WAIT_FOR_INPUT : bool
var PLAYER = load("res://Scenes/player.tscn")

func _process(delta: float) -> void:
	if LOADING:
		var PROGRESS = []
		var status = ResourceLoader.load_threaded_get_status(PATH, PROGRESS)
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print(PROGRESS[0] * 100)
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			print("level_loaded")
			set_process(false)
			var SCENE = ResourceLoader.load_threaded_get(PATH)
			_change_level(SCENE)
			queue_free()
	


func _change_level(resource : PackedScene):
	var CURRENT_NODE = resource.instantiate()
	var player_NODE = PLAYER.instantiate()
	get_tree().root.add_child(CURRENT_NODE)
	
	for item in get_tree().root.get_children():
		if item.get_class() == "Node3D" && item != CURRENT_NODE:
			get_tree().root.remove_child(item)
	queue_free()
	

func _load_level(PATH : String):
	self.PATH = PATH
	show()
	if(ResourceLoader.has_cached(PATH)):
		ResourceLoader.load_threaded_get(PATH)
	else:
		ResourceLoader.load_threaded_request(PATH, "", true)
		LOADING = true
