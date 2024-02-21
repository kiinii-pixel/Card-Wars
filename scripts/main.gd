extends Node2D

func _ready():
	#create_resources()
	pass

func _on_draw_card_add_card():
	var legal_cards = [7, 501, 505, 460, 499, 81, 114, 124, 215, 340, 344, 437, 480]
	var hand = get_node("Hand")
	hand.add_card(legal_cards.pick_random())

func _on_random_card_pressed():
	var hand = get_node("Hand")
	hand.add_random_card()

# Creates Resources (.tres) for each card in the JSON
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()
