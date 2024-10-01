class_name InPlay extends State


@export var card_sound : AudioStreamPlayer2D


func enter():
	drag_component.allow_drag = false
	card.is_inside = false
	card_sound.play()
	card.scale = Vector2(0.5, 0.5)
	Global.is_dragging = false
	card.reparent(card.body_ref)
	await drag_component.move(card.body_ref.global_position, 0.2)
	card.position = Vector2(0, 0)
	card.z_index = 4

func update(_delta : float):
	if card.get_owner() is Pile:
		Transitioned.emit(self, "discarded")
