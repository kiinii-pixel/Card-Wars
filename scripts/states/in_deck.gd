class_name InDeck extends State


func enter():
	card.drag_component.allow_drag = false
	card.flip()

# If Card is in Hand or in GridContainer (Deckbuilder), transition to in_hand.
func update(_delta : float):
	if card.get_parent() is Hand or GridContainer:
		Transitioned.emit(self, "in_hand")
