class_name dragging extends State



func enter():
	Global.is_dragging = true


func update(_delta : float):
	if card.is_inside:
		Transitioned.emit(self, "overlapping")
	elif Input.is_action_just_released("action_key"):
		drag_component.move(drag_component.initial_pos, 0.3) # go back
		Transitioned.emit(self, "in_hand")
		Global.is_dragging = false
