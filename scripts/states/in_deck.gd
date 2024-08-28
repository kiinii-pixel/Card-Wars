class_name InDeck extends State

@export var card : Card

var face_up : bool
var allow_drag : bool

func enter():
	face_up = false
	allow_drag = false
