class_name InPlay extends State


@export var card_sound : AudioStreamPlayer2D


func enter():
	card.is_inside = false
	card.drag_component.allow_drag = false
	card_sound.play()
	Global.is_dragging = false
	card.scale = Vector2(0.5, 0.5)
	await card.drag_component.move(card.body_ref.global_position, 0.2)
	#card.reparent(card.body_ref)
	card.position = Vector2(0, 0)


func update(_delta : float):
	if card.get_parent() is Node2D:
		Transitioned.emit(self, "discarded")
		print("discard")
