class_name Landscape extends Node2D

var landscape_type = 'blueplains'
@export var art_variant = 3

func _ready():
	load_image()

func _process(_delta):
	pass

func _on_area_2d_area_entered(_area):
	# TO DO: create transparent dublicate of current card in center of landscape
	pass
	
func _on_area_2d_area_exited(_area):
	pass

func load_image():
	var image_path = "res://assets/images/landscapes/" + landscape_type + String.num(art_variant) + ".png"
	$LandscapeImage.texture = load(image_path)
