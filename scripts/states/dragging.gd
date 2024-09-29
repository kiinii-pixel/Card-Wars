class_name dragging extends State

var drag_component

func enter():
	Global.is_dragging = true
	drag_component = card.drag_component


func update(_delta : float):
	if Input.is_action_just_released("action_key"):
			Global.is_dragging = false
			if card.is_inside: # If the card is released/placed inside a Landscape
				card.reparent(card.body_ref)
				drag_component.move(card.body_ref.global_position, 0.2)
				Transitioned.emit(self, "in_play")
				drag_component.allow_drag = false
			else:
				drag_component.move(drag_component.initial_pos, 0.3) # go back
				Transitioned.emit(self, "in_hand")
