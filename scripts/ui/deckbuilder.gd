extends Control

@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/objects/card.tscn")

func _ready():
	#load_deck()
	add_card()

func add_card():
	var list = preloader.get_resource_list()
	for instance in list:
		var card = CARD.instantiate()
		#card.custom_minimum_size = Vector2(693, 980)
		card.data = preloader.get_resource(instance)
		card.load_image()
		if card.get_node("%CardImage").texture != null:
			$ScrollContainer/GridContainer.add_child(card)
			card.state_mashine.current_state = card.state_mashine.states["in_deck"]
			card.drag_component.allow_drag = true
			card.get_node("drag_component").scale_down(0.1)
		else:
			card.queue_free()

#		var sprite = Sprite2D.new()
#		var sub_viewport = card.%SubViewport # Used to Render the Card again
#		var img = sub_viewport.get_viewport().get_texture().get_image() # Retrieve the captured Image using get_image().
#		var tex = ImageTexture.create_from_image(img) 		# Convert Image to ImageTexture.
#		sprite.texture = tex # Set sprite texture.
#		$ScrollContainer/GridContainer.add_child(tex)

#func load_deck():
#	for card in cards: # add cards to deck in random order
#		add_card(cards.pick_random())


func _on_back_pressed():
	queue_free()
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
