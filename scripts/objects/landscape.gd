class_name Landscape extends Node2D

var empty : bool = true
@export var art_variant = 3
@export_enum("blueplains", "cornfields", "icylands", "nicelands",
"sanylands", "useswamps") var landscape_type

func _ready():
	load_image()

func _process(_delta):
	pass

func load_image():
	var image_path = "res://assets/images/landscapes/" + String.num(landscape_type) + String.num(art_variant) + ".png"
	%LandscapeImage.texture = load(image_path)


func _on_child_order_changed() -> void:
	if get_child_count() == 4:
		empty = false
	if get_child_count() == 3:
		empty = true
