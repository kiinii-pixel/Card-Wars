extends Node2D
var deck : Array

func _ready():
	#create_resources()
	deck = load("res://data/decks/finn.tres").deck
	$Hand.add_cards(5)

func _on_draw_card_add_card():
	var cards = $Deck/Cards.get_children()
	var random_card = cards.pick_random()
	if random_card != null:
		var hand = get_node("Hand")
		hand.add_card_to_hand(random_card)

# Creates Resources (.tres) for each card in the JSON
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()
