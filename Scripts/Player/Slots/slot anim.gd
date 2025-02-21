extends PLAYERSLOTS_SCROLLING
class_name SLOTS

var lock = false
var Local_Current_slot_selected = 1

@export var Local_Slot_Numb = 1



func _process(_delta: float) -> void:
	if SlotBase.Current_slot_selected == Local_Slot_Numb:
		if lock == false:
			$anim.play("grow")
			lock = true
	else:
		if lock == true:
			$anim.play_backwards("grow")
			lock = false
	
	
	
	
	if Local_Slot_Numb == 1:
		if SlotBase.ID_ONE == null:
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_ONE == "pistol":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_ONE == "rifle":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_ONE == "axe":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = true
			$sprite/KeySlots.visible = false
		if SlotBase.ID_ONE == "key":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = true
	if Local_Slot_Numb == 2:
		if SlotBase.ID_TWO == null:
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_TWO == "pistol":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_TWO == "rifle":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_TWO == "axe":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = true
			$sprite/KeySlots.visible = false
		if SlotBase.ID_TWO == "key":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = true
	if Local_Slot_Numb == 3:
		if SlotBase.ID_THREE == null:
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_THREE == "pistol":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_THREE == "rifle":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_THREE == "axe":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = true
			$sprite/KeySlots.visible = false
		if SlotBase.ID_THREE == "key":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = true
	if Local_Slot_Numb == 4:
		if SlotBase.ID_FOUR == null:
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_FOUR == "pistol":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_FOUR == "rifle":
			$sprite/Pistol.visible = true
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = false
		if SlotBase.ID_FOUR == "axe":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = true
			$sprite/KeySlots.visible = false
		if SlotBase.ID_FOUR == "key":
			$sprite/Pistol.visible = false
			$sprite/Axe.visible = false
			$sprite/KeySlots.visible = true
