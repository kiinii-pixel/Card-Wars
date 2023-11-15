extends Node2D

func _ready():
	modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)

func _process(delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
