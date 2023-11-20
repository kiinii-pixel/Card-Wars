extends Node2D

const CARD = preload("res://scenes/card.tscn")

func _ready():
	add_5_cards()

func add_5_cards() -> void:
	for _x in 5:
		var card = CARD.instantiate()
		add_child(card)
