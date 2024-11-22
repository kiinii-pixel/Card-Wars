extends Control

@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/objects/card.tscn")

var matches : Array = []
var items

func _ready():
	load_cards()
	items = $ScrollContainer/GridContainer.get_children()


func load_cards():
	var list = preloader.get_resource_list()
	for instance in list:
		create_card(instance)


func create_card(instance):
	var card = CARD.instantiate()
	card.data = preloader.get_resource(instance)
	card.load_image()
	if card.get_node("%CardImage").texture != null:
		$ScrollContainer/GridContainer.add_child(card) # Add Card to Container
		$ScrollContainer/GridContainer.cards.append(card) # Add Card to cards Array
		card.state_mashine.current_state = card.state_mashine.states["in_deck"]
	else:
		card.queue_free()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")


func _on_searchbar_text_changed(new_text: String) -> void:
	new_text = new_text.to_lower()
	if new_text == "":
		for card in items:
			card.show()
	else:
		matches.clear()
		for card in items:
			if new_text in card.data.card_name.to_lower():
				matches.append(card)
				card.drag_component.scale_down(0.2)
		for card in items:
			#card.show() if card in matches else card.hide()
			if card in matches:
				card.show()
			else:
				card.hide()


func _on_savedeck_pressed() -> void:
	%ItemList/DeckList.save_deck()
