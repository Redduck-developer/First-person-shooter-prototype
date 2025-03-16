extends CharacterBody3D

@export var SPEED = 45

func _process(delta: float) -> void:
	var direction = (self.global_transform.basis * Vector3(0, 0, -10000)).normalized()
	velocity = direction * SPEED
	
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not player:
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_timer_2_timeout() -> void:
	$MeshInstance3D.visible = true
	
