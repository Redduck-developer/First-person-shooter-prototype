extends RayCast3D


func _hit():
	if get_collider() is prop:
		if get_collider().is_breakable == true:
			get_collider()._break()
	if get_collider() is prop_node3d:
		if get_collider().is_breakable == true:
			get_collider()._break()
	if get_collider() is door:
		if get_collider().is_breakable == true:
			get_collider()._break()
	if get_collider() is enemy:
		print("gatcha stupid idiot")
		get_collider()._hurt(20)
	if is_colliding() == true:
		$SpringArm3D/GPUParticles3D.emitting = true
		$SpringArm3D/Clang.play(0)

func _kick():
	if get_collider() is prop:
		$SpringArm3D/GPUParticles3D.emitting = true
		get_collider()._kicked()
	if get_collider() is enemy:
		$SpringArm3D/GPUParticles3D.emitting = true
		get_collider()._hurt(5)
		if get_collider().parryable == true:
			get_collider().parry = true
			%parry_animation.play("parried")
	if get_collider() is door:
		$SpringArm3D/GPUParticles3D.emitting = true
