class_name Pile extends Node2D

@export var deck_space : Image

func _ready():
	$"Deck Space".texture = deck_space

# Returns the Top Card.
func get_top_card():
	return $Cards.get_child_count() - 1

# Returns the Card x Cards from bottom. get_card(0) returns bottom Card.
func get_card(card : int):
	return $Cards.get_child(card)

# Returns all Cards with the given Name.
func get_cards_named(searched_name : String):
	var cards : Array = [] # Array of Cards returned at the End
	for card in $Cards.get_children(): # Iterate through Cards in Pile
		if card.name == searched_name:
			cards.append(card) # Append current card to Array
	return cards
