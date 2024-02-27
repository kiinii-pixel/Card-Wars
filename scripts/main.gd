extends Node2D
var deck : Array

func _ready():
	#create_resources()
	deck = load("res://data/decks/finn.tres").deck
	for i in 5:
		$Hand.draw()


func _on_draw_card_add_card():
	get_node("Hand").draw()
#	var cards = $Deck/Cards.get_children()
#	var random_card = cards.pick_random()
#	if random_card != null:
#		var hand = get_node("Hand")
#		hand.add_card_to_hand(random_card)

# Creates Resources (.tres) for each card in the JSON
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()

func _on_reset_pressed():
	for n in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(n)
		n.queue_free()
	for n in $Hand.get_children():
		$Hand.remove_child(n)
		n.queue_free()
	$Deck.offset = Vector2(0, 0)
	$Deck.load_deck()
