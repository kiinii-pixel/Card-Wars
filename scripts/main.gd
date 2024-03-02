extends Node2D
var deck : Array

func _ready():
	#create_resources()
	deck = load("res://data/decks/finn.tres").deck
	$Hand.draw_multiple(5)
	fight()


func _on_draw_card_add_card():
	await get_node("Hand").draw()

# Creates Resources (.tres) for each card in the JSON
func create_resources():
	for card_id in 511:
		$save_cards.initialize(card_id)
		$save_cards.create_resource()

func fight():
	var landscapes = $Landscapes
	var _enemy_landscapes = $EnemyLandscapes
	
	for landscape in landscapes.get_children():
		if get_child_count() == 4:
			print(landscape.get_child(3))
			print(123)

func _on_reset_pressed():
	for n in $Deck/Cards.get_children():
		$Deck/Cards.remove_child(n)
		n.queue_free()
	for n in $Hand.get_children():
		$Hand.remove_child(n)
		n.queue_free()
	$Deck.offset = Vector2(0, 0)
	$Deck.load_deck()
