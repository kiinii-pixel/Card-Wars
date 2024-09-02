class_name InHand extends State

@export var card : Card

var face_up : bool
var allow_drag : bool

func enter():
	face_up = true
	allow_drag = true

func update(_delta : float):
	if get_parent() == Deck:
		Transitioned.emit(self, "in_deck")
