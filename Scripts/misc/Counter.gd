extends Label3D

var Count = 0

func _process(delta: float) -> void:
	text = str(Count)

func _on_target_hit() -> void:
	Count = Count + 15
