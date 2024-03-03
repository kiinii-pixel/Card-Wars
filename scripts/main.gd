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
	var landscapes = $Landscapes
	var enemy_landscapes = $EnemyLandscapes
	print(56)
	
	var i = 0
	for landscape in landscapes.get_children():
		if landscape.get_child_count() == 4:
			var new_def = landscape.get_child(3).def - enemy_landscapes.get_child(i).get_child(3).atk
			landscape.get_child(3).%DefenseLabel.text = new_def
		i += 1

	
