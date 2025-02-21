extends Marker3D

var Bullet = preload("res://Scenes/bullets/Light_Bullet.tscn")
var Bullet_medium = preload("res://Scenes/bullets/medium_bullet.tscn")


func _inst_Bullet(pos,rotx,roty):
	var Bullet_inst = Bullet.instantiate()
	pos = self.global_position
	rotx = get_parent().get_parent().rotation.x
	roty = get_parent().get_parent().get_parent().rotation.y
	Bullet_inst.position = pos
	Bullet_inst.rotation.x = rotx
	Bullet_inst.rotation.y = roty
	add_child(Bullet_inst)

func _inst_Bullet_medium(pos,rotx,roty):
	var Bullet_inst = Bullet_medium.instantiate()
	pos = self.global_position
	rotx = get_parent().get_parent().rotation.x
	roty = get_parent().get_parent().get_parent().rotation.y
	Bullet_inst.position = pos
	Bullet_inst.rotation.x = rotx
	Bullet_inst.rotation.y = roty
	add_child(Bullet_inst)
