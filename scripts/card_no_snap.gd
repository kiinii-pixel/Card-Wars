extends Node2D

#how the code would be if card snap wasnt wanted anymore (card snapping its center ot mouse pos)

var selected = false
var mouse_offset = Vector2(0, 0)

func _process(_delta):
	if selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false
