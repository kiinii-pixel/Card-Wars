class_name InHand extends State # Card is in Hand

var clicked : bool

func enter():
	card.flip()
	card.drag_component.allow_drag = true
	card.drag_component.selected = false
	await drag_component.scale_down(0.2)
	card.z_index = 4
	drag_component.mouse_entered.connect(_on_drag_component_mouse_entered)
	drag_component.mouse_exited.connect(_on_drag_component_mouse_exited)
	clicked = false


func update(_delta : float):
	if Input.is_action_just_released("action_key"):
		if clicked:
			drag_component.mouse_entered.disconnect(_on_drag_component_mouse_entered)
			drag_component.mouse_exited.disconnect(_on_drag_component_mouse_exited)
			Transitioned.emit(self, "hovering")
 

func _on_drag_component_mouse_entered() -> void:
	if not Input.is_action_pressed("action_key"):
		drag_component.mouse_entered.disconnect(_on_drag_component_mouse_entered)
		drag_component.mouse_exited.disconnect(_on_drag_component_mouse_exited)
		Transitioned.emit(self, "hovering")
	elif Input.is_action_pressed("action_key"):
		clicked = true


func _on_drag_component_mouse_exited() -> void:
	clicked = false
