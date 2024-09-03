class_name InHand extends State

@onready var card : Card

var allow_drag : bool

func enter():
	allow_drag = true
	card.flip()
	card.drag_component.allow_drag = true

func update(_delta : float):
	if card.get_parent() is Deck:
		Transitioned.emit(self, "in_deck")
