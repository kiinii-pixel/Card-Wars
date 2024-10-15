class_name InDeck extends State


func enter():
	card.drag_component.allow_drag = false

# If Card is in Hand or in GridContainer (Deckbuilder), transition to in_hand.
func update(_delta : float):
	if card.get_parent() is Hand or card.get_parent() is GridContainer:
		Transitioned.emit(self, "in_hand")
