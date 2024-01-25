extends Node2D

var rng = RandomNumberGenerator.new()

func _on_draw_card_add_card():
	var legal_cards = [7, 501, 505, 460, 499, 81, 114, 124, 215, 340, 344, 437, 480]
	var hand = get_node("Hand")
	hand.add_specific_card(legal_cards.pick_random())

func _on_random_card_pressed():
	var random_id = rng.randf_range(1, 420)
	var hand = get_node("Hand")
	hand.add_specific_card(random_id)
