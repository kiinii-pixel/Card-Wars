class_name InDeck extends State

@onready var card : Card

func enter():
	card.flip()

func update(_delta : float):
	if card.get_parent() is Hand:
		Transitioned.emit(self, "in_hand")
