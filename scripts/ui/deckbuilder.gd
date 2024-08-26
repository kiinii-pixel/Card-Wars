extends Control

@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/card.tscn")

func _ready():
	#load_deck()
	add_card()

func add_card():
	var list = preloader.get_resource_list()
	for instance in list:
		var card = CARD.instantiate()
		#card.custom_minimum_size = Vector2(693, 980)
		card.data = preloader.get_resource(instance)
		$ScrollContainer/GridContainer.add_child(card)
		#card.scale = Vector2(0.25, 0.25)
		card.get_node("drag_component").scale_down(0.1)
		card.get_node("%AnimationPlayer").play("card_flip")
		card.drag_component.allow_drag = true

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
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
