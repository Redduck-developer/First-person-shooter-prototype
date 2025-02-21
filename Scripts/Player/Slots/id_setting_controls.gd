extends PLAYERSLOTS
class_name PLAYERSLOTS_SCROLLING

@onready var p = SlotBase

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("scroll_up"):
		p.Current_slot_selected = p.Current_slot_selected + 1
		AmmoManager.switched = true
		SlotBase.switched = true
		print(p.Current_slot_selected)
		print(p.current_slot_data)
		print(p.ID_ONE)
	if Input.is_action_just_pressed("scroll_down"):
		p.Current_slot_selected = p.Current_slot_selected - 1
		AmmoManager.switched = true
		SlotBase.switched = true
		print(p.Current_slot_selected)
		print(p.current_slot_data)
		print(p.ID_ONE)
	if Input.is_action_just_pressed("one"):
		p.Current_slot_selected = 1
		AmmoManager.switched = true
		SlotBase.switched = true
	if Input.is_action_just_pressed("two"):
		p.Current_slot_selected = 2
		AmmoManager.switched = true
		SlotBase.switched = true
	if Input.is_action_just_pressed("three"):
		p.Current_slot_selected = 3
		AmmoManager.switched = true
		SlotBase.switched = true
	if Input.is_action_just_pressed("four"):
		p.Current_slot_selected = 4
		AmmoManager.switched = true
		SlotBase.switched = true
	
	if p.Current_slot_selected > p.Slot_numb:
		p.Current_slot_selected = 1
	if p.Current_slot_selected < 1:
		p.Current_slot_selected = p.Slot_numb
	
	
	
