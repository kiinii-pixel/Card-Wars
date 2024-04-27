extends Node2D
var deck : Array # Empty Array that a deck can be loaded into.
@onready var card_sound = $card_sound # Will likely be moved somewehre else

func _ready():
	#create_resources()
	deck = load("res://data/decks/finn.tres").deck # Load Finn's Deck
	$Hand.draw_multiple(5) # Draw 5 Cards to hand

# When the Draw Card Button is pressed
func _on_draw_card_pressed():
	await get_node("Hand").draw() # Draw a Card
	card_sound.play() # Play Card Sound

# When Reset Button is pressed
func _on_reset_pressed():
	for card in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(card)
		card.queue_free() # Delete Cards in Deck
	for card in $Hand.get_children():
		$Hand.remove_child(card)
		card.queue_free() # Delete Cards in Hand
	$Deck.offset = Vector2(0, 0) # Reset offset (Card 3D effect)
	$Deck.load_deck()

func _on_fight_pressed():
	var landscapes = $Landscapes # Node that holds 4 Landscapes
	var enemy_landscapes = $EnemyLandscapes # Node that holds 4 (enemy) landscapes
	var index = 0 # Used to count current Landscape in For Loop

	for landscape in landscapes.get_children(): # Goes through all Cards.
		if landscape.get_child_count() == 4: # If there's a Card on the landscape
			var creature = landscape.get_child(3) # Get the card / creature
			var opposing_creature = enemy_landscapes.get_child(index).get_child(3)
			if opposing_creature != null:
				deal_damage(creature, opposing_creature)
				deal_damage(opposing_creature, creature)
				if creature.def <= 0: # When Def reaches 0: remove
					creature.queue_free()
				if opposing_creature.def <= 0:
					opposing_creature.queue_free()
			else:
				pass
				#Decrease Opponent's HP
		else:
			pass
			#if enemy_landscape.get_child_count() == 4:
			#decrease own health
		index += 1
		
func deal_damage(creature, opponent):
	creature.def -= opponent.atk # decrease hp by opponents atk
	creature.load_values() # refresh values

# Creates Resources (.tres) for each card in the JSON
# This was only used to create Resources, doesnt do anything in game.
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()
