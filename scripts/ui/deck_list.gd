class_name DeckList extends StaticBody2D

var item_list : ItemList
var resource_list : Dictionary
const MAX_DECK_SIZE : int = 40

func _ready() -> void:
	item_list = %ItemList
	#resource_list.resize(MAX_DECK_SIZE)

func add_card_to_list(card):
	var card_name = card.data.card_name
	
	if item_list.item_count <= MAX_DECK_SIZE: # If Deck isn't full
		for item in item_list.item_count: # Iterate through Cards by number
			# if current card to add is already in deck
			var item_text = item_list.get_item_text(item)
			if item_text == card_name:
				resource_list[card_name] += 1
				item_list.set_item_text(item, card_name + " x2")
				#card_count.to_string()
				return
			elif item_text == card_name + " x2":
				resource_list[card_name] += 1
				item_list.set_item_text(item, card_name + " x3")
				return
			elif item_text == card_name + " x3":
				return
		item_list.add_item(card_name, card.data.image)
		resource_list[card_name] = 1

func save_deck():
	var root = get_owner()
	var new_deck = DeckResource.new()
	print(root.hero_button.get_item_text(root.hero_button.get_selected_id()))
	for i in range(MAX_DECK_SIZE):
		new_deck.deck[i] = resource_list[i]
	
