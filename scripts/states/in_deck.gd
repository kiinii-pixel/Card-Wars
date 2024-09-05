class_name in_deck extends State

func enter():
	card.drag_component.allow_drag = false
	card.flip()

func update(_delta : float):
	if card.get_parent() is Hand:
		Transitioned.emit(self, "in_hand")
