extends Node2D

func _on_draw_card_add_card():
	var hand = get_node("Interface/Hand")
	hand.add_specific_card(7)
