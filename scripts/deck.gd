extends Node
# A deck is a Resource consisting of a Character
# and an Array containing Card Resources

const CARD : PackedScene = preload("res://scenes/card.tscn")
var deck : Resource = preload("res://data/decks/finn.tres")
var offset : Vector2 # makes cards have slight offset (pseudo 3D)

func _ready():
	load_deck()

func add_card(card_name):
	var card = CARD.instantiate()
	card.card_name = card_name
	$Cards.add_child(card, true)
	card.scale = Vector2(0.25, 0.25)
	card.position = offset
	offset += Vector2(0.2, 0.2)

func load_deck():
	var cards = deck.deck
	for card in cards: # add cards to deck in random order
		add_card(cards.pick_random().card_name)
