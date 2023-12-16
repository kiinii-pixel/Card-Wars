class_name Landscape extends Node2D

var type = 'blueplains'
var art_variant = 3

func _ready():
	$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)
	load_image()

func _process(_delta):
#	if Global.is_dragging: #when a card is being dragged
#		$ColorRect.visible = true #highlight landscape
#	else:
#		$ColorRect.visible = false #remove highlight
	pass

func _on_area_2d_area_entered(_area):
	#$ColorRect.modulate = Color(Color.GREEN_YELLOW, 1) #change highlight color
	# TO DO: create transparent dublicate of current card in center of landscape
	pass
	
func _on_area_2d_area_exited(_area):
	#$ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)
	pass

func load_image():
	var image_path = "res://assets/images/landscapes/" + type + String.num(art_variant) + ".png"
	$Landscape_Image.texture = load(image_path)

#func _init(landscape, variant):
#	type = landscape
#	art_variant = variant
