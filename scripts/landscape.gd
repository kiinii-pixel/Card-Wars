class_name Landscape extends Node2D

func _ready():
	$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)

func _process(_delta):
	if Global.is_dragging: #when a card is being dragged
		$ColorRect.visible = true #highlight landscape
	else:
		$ColorRect.visible = false #remove highlight

func _on_area_2d_area_entered(_area):
	#print("Another object entered:", area.name)
	$ColorRect.modulate = Color(Color.GREEN_YELLOW, 1) #change highlight color

func _on_area_2d_area_exited(_area):
	#print("Another object exited:", area.name)
	$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)
