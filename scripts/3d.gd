extends Node3D

@onready var texture = preload("res://assets/images/frames/Blue Plains.png")

func _ready():
	$card/Card.get_mesh().get("surface_2/material").set_texture(StandardMaterial3D.TEXTURE_ALBEDO, texture)
