class_name Hand extends Node2D

#signal card_played
const CARD = preload("res://scenes/objects/card.tscn")
@export var deck : Deck

@export var spread_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve

var hand = self
var hand_width = 60
const MAX_HAND_WIDTH = 300 #Maximum hand width
var hand_height = 10
const MAX_HAND_HEIGHT = 100 # Maximum hand height

func _ready() -> void:
	var viewport = get_viewport().get_visible_rect()
	
	position.x = viewport.size.x / 2
	#position.y = (viewport.size.y / 10) * 9
	position.y = (viewport.size.y / 1.15)

func draw() -> void:
	var top_card = deck.get_top_card()
	if top_card >= 0: # If Deck isn't empty
		var card = deck.get_card(top_card)
		card.reparent(hand, true)
		hand.emit_signal("child_order_changed")

func draw_multiple(amount) -> void:
	for _x in range(amount):
		draw()

func _on_child_order_changed():
	hand = self
	
	for card in hand.get_children():
		var hand_ratio : float = 0.25

		if get_child_count() > 1:
			hand_ratio = float(card.get_index()) / float(hand.get_child_count() - 1)

			# Adjust Collision Shape Size depending on hand_ration?

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
		move(card, destination.origin, 0.3)
		#card.global_position = destination.origin

func move(object : Object, destination : Vector2, time : float):
	if is_inside_tree():
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
		tween.tween_property(object, "global_position", destination, time)
		await tween.finished

func _on_card_played():
	pass
