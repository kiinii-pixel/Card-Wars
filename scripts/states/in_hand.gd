class_name InHand extends State # Card is in Hand


func enter():
	card.flip()
	card.drag_component.allow_drag = true
	card.z_index = 4
	drag_component.scale_down(0.2)
	drag_component.mouse_entered.connect(_on_drag_component_mouse_entered)


func update(_delta : float):
	pass


func _on_drag_component_mouse_entered() -> void:
	print("mouse entered")
	if not Input.is_action_pressed("action_key"):
		drag_component.mouse_entered.disconnect(_on_drag_component_mouse_entered)
		Transitioned.emit(self, "hovering")
		print("hovering")
