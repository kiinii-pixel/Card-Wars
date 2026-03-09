class_name Hovering extends State # Mouse is hovering over Card in Hand


const SCALE_NORMAL: Vector2 = Vector2(1, 1)
const SCALE_ZOOMED: Vector2 = Vector2(1.2, 1.2)


func enter():
	for child in card.get_parent().get_children():
		if child != card && child.state_mashine.current_state is Hovering:
			child.state_mashine.current_state.Transitioned.emit(child.state_mashine.current_state, "in_hand")
	drag_component.selected = true
	card.z_index = 5
	drag_component.scale_up(0.2)


func update(_delta : float):
	if drag_component.selected and Input.is_action_just_pressed("action_key"):
		Transitioned.emit(self, "dragging")

func _on_drag_component_mouse_exited() -> void:
	if card.state_mashine.current_state is Hovering:
		Transitioned.emit(self, "in_hand")
