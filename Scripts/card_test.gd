extends Node2D


var selected = false
var mouse_offset = Vector2(0, 0)

func _process(_delta):
	if Input.is_action_pressed("left_click") and selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position() + mouse_offset


func _on_area_2d_mouse_entered():
	selected = true


func _on_area_2d_mouse_exited():
	selected = false
