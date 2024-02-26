extends Node2D

signal card_played
const CARD = preload("res://scenes/card.tscn")

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
	#add_cards(5)

func add_cards(amount) -> void:
	for _x in range(amount):
		add_random_card()

func add_card_to_hand(card):
	card.get_node("SubViewportContainer/PanelContainer/AnimationPlayer").play("card_flip")
	await move(card, hand.position, 0.3)
	card.reparent(hand, true)
	hand.emit_signal("child_order_changed")

func add_random_card():
	var cards = get_parent().get_node("Deck/Cards").get_children()
	var random_card = cards.pick_random()
	if random_card != null:
		hand.add_card_to_hand(random_card)

func _on_child_order_changed():
	hand = self
	
	for card in hand.get_children():
		var hand_ratio = 0.25

		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)

			hand_width = get_child_count() * 60
			if hand_width > MAX_HAND_WIDTH:
				hand_width = MAX_HAND_WIDTH
			hand_height = get_child_count() * 5
			if hand_height > MAX_HAND_HEIGHT:
				hand_height = MAX_HAND_HEIGHT

		var destination = hand.global_transform #set destination to hand position
		#change the x position of the current card, based on its index
		destination.origin.x += spread_curve.sample(hand_ratio) * hand_width
		destination.origin.y -= height_curve.sample(hand_ratio) * hand_height
		card.global_position = destination.origin

func move(object, destination : Vector2, time : float):
	var tween = create_tween()
	tween.tween_property(object, "global_position", destination, time).set_ease(Tween.EASE_OUT)
	await tween.finished

func _on_card_played():
	pass
