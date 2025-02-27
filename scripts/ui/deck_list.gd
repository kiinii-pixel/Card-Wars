class_name DeckList extends StaticBody2D

var item_list : ItemList
var card_list : Dictionary # Keys: Card Names | Values: Integers (1 - 3)
var resource_list : Dictionary # Dictionary storing Card Resources
const MAX_DECK_SIZE : int = 40
var card_count : int

func _ready() -> void:
	item_list = %ItemList
	#card_list.resize(MAX_DECK_SIZE)

func add_card_to_list(card):
	var card_name = card.data.card_name
	
	if card_count <= MAX_DECK_SIZE - 1: # If Deck isn't full
		print(item_list.item_count)
		for item in item_list.item_count: # Iterate through Cards by number
			# if current card to add is already in deck
			var item_text = item_list.get_item_text(item)
			if item_text == card_name:
				card_list[card_name] += 1 # Increments the amount for that Card by 1
				resource_list[card.data] += 1
				card_count += 1
				item_list.set_item_text(item, card_name + " x2")
				#card_count.to_string()
				return
			elif item_text == card_name + " x2": # If Card is already in Deck twice
				card_list[card_name] += 1 # Increments the amount for that Card by 1
				card_count += 1
				resource_list[card.data] += 1
				item_list.set_item_text(item, card_name + " x3")
				return
			elif item_text == card_name + " x3": # If Card is already in Deck 3 times
				return
		# If the Card is not in Deck yet
		item_list.add_item(card_name, card.data.image)
		card_list[card_name] = 1 # Sets the amount for that Card to 1
		resource_list[card.data] = 1 # Create Key Pair (Card Resource | Integer)
		card_count += 1

func save_deck():
	var root = get_owner() # deckbuilder node
	var new_deck = DeckResource.new()
	new_deck.deck.resize(40)
	print(root.find_child("hero_button", true, false).get_item_text(root.find_child("hero_button", true, false).get_selected_id()))
	var i : int = 0
	for card in resource_list: # Iterating through card_list
		new_deck.deck[i] = card # Save current entry in the new_deck resource at position i
		i += 1

	var save_result = ResourceSaver.save(new_deck, 'user://resources/' + 'new deck' + '.res')
	if save_result != OK:
		print(save_result)
