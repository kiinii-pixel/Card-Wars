class_name InHand extends State


func enter():
	card.flip()
	card.drag_component.allow_drag = true
	card.z_index = 4


func update(_delta : float):
	if drag_component.selected:
		Transitioned.emit(self, "hovering")
