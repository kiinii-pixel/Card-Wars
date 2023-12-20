extends Node2D

func _on_draw_card_add_card():
	var legal_cards = [7, 501, 505, 460, 499]
	var hand = get_node("Hand")
	hand.add_specific_card(legal_cards.pick_random())
