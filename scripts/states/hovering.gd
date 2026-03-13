class_name Hovering extends State # Mouse is hovering over Card in Hand


const SCALE_NORMAL: Vector2 = Vector2(1, 1)
const SCALE_ZOOMED: Vector2 = Vector2(1.2, 1.2)


func enter():
	for child in card.get_parent().get_children():
		if child is Card && child != card && child.state_mashine.current_state is Hovering:
			child.rotation = child.hand_rotation
			child.state_mashine.current_state.Transitioned.emit(child.state_mashine.current_state, "in_hand")
	drag_component.selected = true
	card.z_index = 5
	#drag_component.scale_up(0.2)
	card.move_up_image(200)
	card.scale_up_image(0.2)

	card.rotation = 0
	#card.drag_component.move(card.get_global_position() + Vector2(0, -100), 0.2)


func update(_delta : float):
	if drag_component.selected and Input.is_action_just_pressed("action_key"):
		Transitioned.emit(self, "dragging")

func _on_drag_component_mouse_exited() -> void:
	if card.state_mashine.current_state is Hovering:
		card.rotation = card.hand_rotation
		#card.drag_component.move(card.get_global_position() + Vector2(0, 100), 0.2)
		Transitioned.emit(self, "in_hand")
