class_name Hovering extends State # Mouse is hovering over Card in Hand


const SCALE_NORMAL = Vector2(1, 1)
const SCALE_ZOOMED = Vector2(1.2, 1.2)


func enter():
	#scale all cards in hand down (only one scaled at a time)
	for child in card.get_parent().get_children():
		if child.z_index == 5 and child != card:
			child.z_index = 4
			child.drag_component.scale_down(0.2)
			child.drag_component.selected = false
	drag_component.selected = true
	card.z_index = 5
	drag_component.scale_up(0.2)
	#drag_component.move(card.global_position + Vector2(0, -50), 0.5) # Move Card Upwards
	card.get_node("SubViewportContainer").position += Vector2(0, -50)


func update(_delta : float):
	if drag_component.selected and Input.is_action_just_pressed("action_key"):
		Transitioned.emit(self, "dragging")


func _on_drag_component_mouse_exited() -> void:
	if card.state_mashine.current_state is Hovering:
		card.get_node("SubViewportContainer").position += Vector2(0, 50)
		drag_component.selected = false
		Transitioned.emit(self, "in_hand")
	
	#if get_owner().scale != SCALE_NORMAL and drag_component.allow_drag and not drag_component.selected:
		#print("happening")
		#drag_component.scale_down(0.2)
		#card.z_index = 4
