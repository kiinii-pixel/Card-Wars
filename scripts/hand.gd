extends Node2D

signal card_played
const CARD = preload("res://scenes/card.tscn")

@export var spread_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve
var hand = self
const HAND_WIDTH = 300 # Maximum hand width
const HAND_HEIGHT = 50 # Maximum hand height
#var MAX_HAND_WIDTH = 600

func _ready():
#	add_cards(1)
	add_specific_card(7)
	add_specific_card(501)
	add_specific_card(505)
	add_specific_card(460)
	add_specific_card(499)

func add_cards(amount) -> void:
	for _x in range(amount):
		var card = CARD.instantiate()
		#card.load_image()
		add_child(card)
		card.scale = Vector2(0.5, 0.5)

func add_specific_card(id):
	var card = CARD.instantiate()
	card.card_id = id
	add_child(card)
	card.scale = Vector2(0.5, 0.5)

func _on_child_order_changed():
	hand = self
	
	for card in hand.get_children():
		var hand_ratio = 0.5

		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)

#		hand_width = get_child_count() * 40
#		if hand_width > MAX_HAND_WIDTH:
#			hand_width = MAX_HAND_WIDTH

		var destination = hand.global_transform #set destination to hand position
		#change the x position of the current card, based on its index
		destination.origin.x += spread_curve.sample(hand_ratio) * HAND_WIDTH
		destination.origin.y -= height_curve.sample(hand_ratio) * HAND_HEIGHT
		card.global_position = destination.origin

func _on_card_played():
	#remove played card as child and add it as a child to the landscape it was played on
	pass
