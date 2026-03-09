class_name DrawEffect extends Effect

@export var amount: int = 1

func execute(card: Card):
	# Find the hand node (assuming it's in a group or reachable)
	var hand = card.get_tree().get_first_node_in_group("player_hand")
	if hand:
		hand.draw_multiple(amount)
