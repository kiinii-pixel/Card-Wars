extends Control

@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/card.tscn")
#var deck : Resource = preload("res://data/decks/all_cards.tres")
#var deck = preload("res://scenes/deck.tscn")#

var card = CARD.instantiate()

func _ready():
	#load_deck()
	add_card()

func add_card():
	var instance = preloader.get_resource()
	preloader.resources
	print(instance)

#func load_deck():
#	for card in cards: # add cards to deck in random order
#		add_card(cards.pick_random())
