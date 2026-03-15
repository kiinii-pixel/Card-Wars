class_name Landscape extends Node2D

var empty : bool = true
var face_down : bool = false
@export var art_variant: int = 3
enum LANDSCAPES { Blue_Plains, Cornfields, IcyLands, NiceLands,
SandyLands, Useless_Swamps }
@export var landscape_type : LANDSCAPES

func _ready():
	load_image()

func _process(_delta):
	pass

func load_image():
	var image_path: String = "res://assets/images/landscapes/" + str(landscape_type) + str(art_variant) + ".png"
	%LandscapeImage.texture = load(image_path)

func _on_child_order_changed() -> void:
	if get_child_count() >= 3:
		empty = false
	if get_child_count() == 2:
		empty = true

func flip_down() -> void:
	%LandscapeImage.visible = false
	%FaceDownImage.visible = true
	face_down = true

func flip_up() -> void:
	%LandscapeImage.visible = true
	%FaceDownImage.visible = false
	face_down = false
