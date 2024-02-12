extends Node3D

signal card_played
const CARD = preload("res://scenes/card3d.tscn")

@export var spread_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve
var hand = self
var hand_width = 60
const MAX_HAND_WIDTH = 300 #Maximum hand width
var hand_height = 10
const MAX_HAND_HEIGHT = 100 # Maximum hand height
# MOVE is_dragging HERE?

func _ready():
	position.x = get_viewport().get_visible_rect().size.x / 2
	position.y = get_viewport().get_visible_rect().size.y - 100
#	add_cards(1)
#	add_card(7)
#	add_card(505)
#	add_card(460)
#	add_card(499)
#	add_card(81)
	#add_card(26)
	add_cards(5)

func add_cards(amount) -> void:
	for _x in range(amount):
		var card = CARD.instantiate()
		#card.load_image()
		add_child(card)
		#card.scale = Vector3(0.5, 0.5, 0.5)

#func add_card(card_id):
#	var card = CARD.instantiate()
#	card.card_id = card_id
#	add_child(card)
#	card.scale = Vector2(0.5, 0.5)

#func add_random_card():
#	var rng = RandomNumberGenerator.new()
#	var card = CARD.instantiate()
#	card.card_id = rng.randi_range(1, 512)
#	add_child(card)
#	card.scale = Vector2(0.5, 0.5)

#func _on_child_order_changed():
#	hand = self
#
#	for card in hand.get_children():
#		var hand_ratio = 0.5
#
#		if get_child_count() > 1:
#			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)
#
#			hand_width = get_child_count() * 60
#			if hand_width > MAX_HAND_WIDTH:
#				hand_width = MAX_HAND_WIDTH
#			hand_height = get_child_count() * 5
#			if hand_height > MAX_HAND_HEIGHT:
#				hand_height = MAX_HAND_HEIGHT
#
#		var destination = hand.global_transform #set destination to hand position
#		#change the x position of the current card, based on its index
#		destination.origin.x += spread_curve.sample(hand_ratio) * hand_width
#		destination.origin.y -= height_curve.sample(hand_ratio) * hand_height
#		card.global_position = destination.origin

#func _on_card_played():
#	#remove played card as child and add it as a child to the landscape it was played on
#	pass
