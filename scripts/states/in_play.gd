class_name in_play extends State

@export var card_sound : AudioStreamPlayer2D


func enter():
	card.drag_component.scale_down(0.2)
	card.scale = Vector2(0.5, 0.5)
	card.drag_component.allow_drag = false
	card_sound.play()


func update(_delta : float):
	if card.get_parent() is Node2D:
		Transitioned.emit(self, "discarded")
		print("discard")
