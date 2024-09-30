class_name hovering extends State


func enter():
	for child in card.get_parent().get_children(): #scale all cards in hand down (only one scaled at a time)
		if child.z_index == 5 and child != card:
			child.z_index = 4
			child.drag_component.scale_down(0.2)
			child.drag_component.selected = false
	drag_component.selected = true
	card.z_index = 5


func update(_delta : float):
	if drag_component.selected and Input.is_action_just_pressed("action_key"):
		Transitioned.emit(self, "dragging")
	if !drag_component.selected:
		Transitioned.emit(self, "in_hand")
