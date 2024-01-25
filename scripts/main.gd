extends Node2D

func _on_draw_card_add_card():
	var legal_cards = [7, 501, 505, 460, 499, 81, 114, 124, 215, 340, 344, 437, 480]
	var hand = get_node("Hand")
	hand.add_card(legal_cards.pick_random())

func _on_random_card_pressed():
	var hand = get_node("Hand")
	hand.add_random_card()

