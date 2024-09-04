class_name InPlay extends State

@onready var card : Card

func enter():
	#card.scale = Vector2(0.5, 0.5)
	pass

func update(_delta : float):
	if card.get_parent() is Node2D:
		Transitioned.emit(self, "discarded")
		print("discard")
