extends Node2D

@export var spread_curve: Curve
var hand = self
var hand_ratio
var hand_width = 100

func _ready():
	add_cards(6)

func add_cards(amount) -> void:
	for _x in range(amount):
		var card = Card.new(7)
#		card.load_image()
		add_child(card)
		card.scale = Vector2(0.5, 0.5)


func _on_child_order_changed():
	hand = self
	#var current = 0
	
	for card in hand.get_children():
		hand_ratio = 0.5

		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)

		if get_child_count() > 5:
			hand_width = 300

		var destination = hand.global_transform
		destination.origin.x += spread_curve.sample(hand_ratio) * hand_width
		
		card.global_position.x = destination.origin.x
