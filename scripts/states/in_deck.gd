class_name InDeck extends State

@onready var card : Card

var allow_drag : bool

func enter():
	allow_drag = false
	card.flip()

func update(_delta : float):
	if card.get_parent() is Hand:
		Transitioned.emit(self, "in_hand")
