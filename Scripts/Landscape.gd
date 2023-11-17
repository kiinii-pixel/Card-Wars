extends Node2D

func _ready():
	$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)

func _process(_delta):
	if Global.is_dragging:
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false
