extends Node

const CARD = preload("res://scenes/card.tscn")
var offset : Vector2

func _ready():
	var deck = preload("res://data/decks/finn.tres")
	var cards = deck.deck
	for card in cards:
		add_card(card.card_name)

func add_card(card_name):
	var card = CARD.instantiate()
	card.card_name = card_name
	$Cards.add_child(card, true)
	card.scale = Vector2(0.25, 0.25)
	card.position = offset
	offset += Vector2(0.2, 0.2)
