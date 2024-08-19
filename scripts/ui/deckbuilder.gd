extends Control

const CARD : PackedScene = preload("res://scenes/ui/card_interface.tscn")
var deck : Resource = preload("res://data/decks/all_cards.tres")
#var deck = preload("res://scenes/deck.tscn")#

var card = CARD.instantiate()

func _ready():
	load_deck()

func add_card(card_name):
	var card = CARD.instantiate()
	card.card_name = card_name
	$Cards.add_child(card, true)
	card.scale = Vector2(0.25, 0.25)
	card.position = offset
	offset += Vector2(0.2, 0.2)
	card.drag_component.allow_drag = false # Cards in Deck shouldnt be draggable

func load_deck():
	var cards = deck.deck
	for card in cards: # add cards to deck in random order
		add_card(cards.pick_random().card_name)
