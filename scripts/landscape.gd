class_name Landscape extends Node2D

var landscape_type = 'blueplains'
@export var art_variant = 3

func _ready():
	load_image()

func _process(_delta):
	pass

func load_image():
	var image_path = "res://assets/images/landscapes/" + landscape_type + String.num(art_variant) + ".png"
	$LandscapeImage.texture = load(image_path)
