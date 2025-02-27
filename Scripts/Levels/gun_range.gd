extends Node3D


func _process(delta: float) -> void:
	if $Labels/Counter.Count == 900:
		$"Props/Doors & keys/key".global_position = $Csg/pipe/Marker3D.global_position
	if $Labels/Counter.Count == 3000:
		$"Props/Doors & keys/key2".global_position = $Csg/pipe/Marker3D.global_position
	if $Labels/Counter.Count == 9000:
		$"Props/Guns/Axe".global_position = $Csg/pipe/Marker3D.global_position
