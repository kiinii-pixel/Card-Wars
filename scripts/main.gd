extends Node2D
var deck : Array

func _ready():
	#create_resources()
	deck = load("res://data/decks/finn.tres").deck
	$Hand.draw_multiple(5)

func _on_draw_card_pressed():
	await get_node("Hand").draw()

# Creates Resources (.tres) for each card in the JSON
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()

func _on_reset_pressed():
	for n in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(n)
		n.queue_free()
	for n in $Hand.get_children():
		$Hand.remove_child(n)
		n.queue_free()
	$Deck.offset = Vector2(0, 0)
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
				creature.def -= opposing_creature.atk
				creature.get_node("%DefenseLabel").text = String.num_int64(creature.def)
				opposing_creature.def -= creature.atk
				opposing_creature.get_node("%DefenseLabel").text = String.num_int64(opposing_creature.def)
				if creature.def <= 0:
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
