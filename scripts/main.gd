extends Node2D


var deck : Array # Empty Array that a deck can be loaded into.
@onready var card_sound = %card_sound # Will likely be moved somewehre else


func _ready():
	deck = load("res://data/decks/finn.tres").deck # Load Finn's Deck
	%Hand.draw_multiple(5) # Draw 5 Cards to hand


# When the Draw Card Button is pressed
func _on_draw_card_pressed():
	await %Hand.draw() # Draw a Card
	card_sound.play() # Play Card Sound


# When Reset Button is pressed
func _on_reset_pressed():
	for card in %Deck/Cards.get_children():
		%Deck/Cards.remove_child(card)
		card.queue_free() # Delete Cards in Deck
	for card in %Hand.get_children():
		%Hand.remove_child(card)
		card.queue_free() # Delete Cards in Hand
	%Deck.offset = Vector2(0, 0) # Reset offset (Card 3D effect)
	%Deck.load_deck()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
	BackgroundMusic.playing = true


func _on_fight_pressed():
	var landscapes = %Landscapes # Node that holds 4 Landscapes
	var enemy_landscapes = %EnemyLandscapes # Node that holds 4 (enemy) landscapes
	var index = 0 # Used to count current Landscape in For Loop

	for landscape in landscapes.get_children(): # Goes through all Cards.
		if !landscape.empty: # If there's a Card on the landscape
			var creature = landscape.get_child(3) # Get the card / creature
			var opposing_creature = null
			if enemy_landscapes.get_child(index).empty == false:
				opposing_creature = enemy_landscapes.get_child(index).get_child(3)
			if opposing_creature != null:
				deal_damage(creature, opposing_creature)
				deal_damage(opposing_creature, creature)
				if creature.def <= 0: # When Def reaches 0: remove
					discard(creature)
				if opposing_creature.def <= 0:
					discard(opposing_creature)
					
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


func discard(creature):
	creature.floop_component.rotate_card(Vector2(0, 0), 0, 0.2)
	creature.drag_component.allow_drag = false
	await creature.drag_component.move($Discard.global_position, 0.2)
	creature.reparent($Discard/Cards)
	creature.position = Vector2(0, 0)
	#creature.scale = Vector2(0.25, 0.25)
	creature.reset_values()
