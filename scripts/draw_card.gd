extends Button

func _pressed():
	var hand = get_node("Interface/Hand")
	hand.add_specific_card(7)
