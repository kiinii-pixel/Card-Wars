class_name Overlapping extends State # Card is being dragged over a Landscape


func enter():
	pass

func update(_delta : float):
	if Input.is_action_just_released("action_key"):
		card.get_node("SubViewportContainer").position += Vector2(0, 50)
		Transitioned.emit(self, "in_play")
	elif !card.is_inside:
		Transitioned.emit(self, "dragging")
