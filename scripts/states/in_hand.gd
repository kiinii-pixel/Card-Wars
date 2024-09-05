class_name InHand extends State

func enter():
	card.flip()
	card.drag_component.allow_drag = true
	card.z_index = 5

func update(_delta : float):
	if card.get_parent() is Deck:
		Transitioned.emit(self, "in_deck")
	elif card.get_parent() is Landscape:
		Transitioned.emit(self, "in_play")
