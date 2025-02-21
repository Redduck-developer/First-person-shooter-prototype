extends RayCast3D


func _hit():
	if get_collider() is prop:
		if get_collider().is_breakable == true:
			get_collider()._break()
	if get_collider() is door:
		if get_collider().is_breakable == true:
			get_collider()._break()
	if get_collider() is enemy:
		print("gatcha stupid idiot")
	if is_colliding() == true:
		$SpringArm3D/GPUParticles3D.emitting = true
		$SpringArm3D/Clang.play(0)
