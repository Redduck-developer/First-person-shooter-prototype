extends CanvasLayer


func _process(_delta: float) -> void:
	$AmmoTexture/Light_ammo_count.text = str(AmmoManager.light_ammo)
	$AmmoTexture/Medium_ammo_count.text = str(AmmoManager.medium_ammo)
	$AmmoTexture/Heavy_ammo_count.text = str(AmmoManager.heavy_ammo)
	$AmmoTexture/Current_ammo_count.text = str(AmmoManager.ammo_left_in_mag)
