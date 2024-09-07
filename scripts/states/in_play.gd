class_name InPlay extends State


@export var card_sound : AudioStreamPlayer2D


func enter():
	card.is_inside = false
	card_sound.play()
	card.scale = Vector2(0.5, 0.5)
	card.position = Vector2(0, 0)
	Global.is_dragging = false


func update(_delta : float):
	if card.get_owner() is Pile:
		Transitioned.emit(self, "discarded")
