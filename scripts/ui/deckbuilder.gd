extends Control

@onready var file_dialog = $ItemList/DeckList/FileLoadDialog
@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/objects/card.tscn")

var matches : Array = []
var items
var count : int = 0

func _ready():
	load_cards()
	items = $ScrollContainer/GridContainer.get_children()


func load_cards():
	var list = preloader.get_resource_list()
	for instance in list:
		create_card(instance)

# Used to save all Cards to Disk as images (for the Discord Bot)
# Enable function call in create_card for this to work
func save_card_images(card):
	var sub_viewport = card.find_child("SubViewport", true, false)

	if not sub_viewport:
		print("Error: SubViewport not found!")
		return

	# Wait for rendering to finish
	await RenderingServer.frame_post_draw 

	var img = sub_viewport.get_texture().get_image()

	if img.is_empty():
		print("Error: Captured image is empty!")
		return

	var node_name = str(card)
	var split_string = node_name.rsplit(":", true, 1)
	print(split_string[0])

	var path = "user://" + str(split_string[0]) + ".jpg"
	var err = img.save_png(path)

	if err == OK:
		print("Saved image:", path)
	else:
		print("Error saving image!")

	count += 1


func create_card(instance):
	var card = CARD.instantiate()
	card.data = preloader.get_resource(instance)
	card.load_image()
	if card.get_node("%CardImage").texture != null:
		$ScrollContainer/GridContainer.add_child(card) # Add Card to Container
		$ScrollContainer/GridContainer.cards.append(card) # Add Card to cards Array
		card.state_mashine.current_state = card.state_mashine.states["in_deck"]
		#save_card_images(card)
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


func _on_import_deck_pressed() -> void:
	file_dialog.visible = true
