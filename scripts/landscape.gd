extends Node2D

class_name Landscape

func _ready():
	
	$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)

func _process(_delta):
	if Global.is_dragging: #when a card is being dragged
		$ColorRect.visible = true #highlight landscape
	else:
		$ColorRect.visible = false #remove highlight

func _on_landscape_entered(landscape):
	$ColorRect.modulate = Color(Color.GREEN_YELLOW, 1) #change highlight color
