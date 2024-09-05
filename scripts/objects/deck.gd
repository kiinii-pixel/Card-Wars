# A deck is a Resource consisting of a Character
# and an Array containing Card Resources
class_name Deck extends Pile

const Card : PackedScene = preload("res://scenes/objects/card.tscn")
@export var deck : Resource # Holds a Deck Resource
var offset : Vector2 # Makes Cards have slight offset (Pseudo 3D)

func _ready():
	load_deck()

func add_card(card_resource):
	var card = Card.instantiate()
	card.data = card_resource
	$Cards.add_child(card, true)
	card.state_mashine.current_state = card.state_mashine.states["in_deck"]
	card.scale = Vector2(0.25, 0.25)
	card.position = offset
	offset += Vector2(0.2, 0.2)
	card.drag_component.allow_drag = false # Cards in Deck shouldnt be draggable

func load_deck():
	var cards = deck.deck
	for card in cards: # add cards to deck in random order
		add_card(cards.pick_random())
