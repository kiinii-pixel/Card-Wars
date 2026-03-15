class_name Dragging extends State # Dragging a Card

var in_deck_list : bool

func enter():
	card.scale_down_image(0.2)
	card.move_down_image()
	Global.is_dragging = true
	if not drag_component.body_entered.is_connected(_on_body_entered):
		drag_component.body_entered.connect(_on_body_entered)


func update(_delta : float):
	if card.is_inside:
		Transitioned.emit(self, "overlapping")
	elif Input.is_action_just_released("action_key"):
		drag_component.move(drag_component.initial_pos, 0.3) # go back
		drag_component.body_entered.disconnect(_on_body_entered)
		card.position += Vector2(0, 50)
		card.rotation = card.hand_rotation
		Transitioned.emit(self, "in_hand")
		Global.is_dragging = false
	if in_deck_list:
		if Input.is_action_just_released("action_key"):
				var decklist: StaticBody2D = card.body_ref
				decklist.add_card_to_list(card.data)
				card.global_position = card.drag_component.initial_pos
				card.scale = Vector2(1, 1)


func exit():
	pass


func _on_body_entered(body):
	if body.is_in_group("droppable"):
		remove_preview(body)
		if body.empty:
			var type = card.data.card_type
			if type == "Creature" and body is Landscape or type == "Building" and body is BuildingZone:
				card.is_inside = true # card is now inside a landcape
				card.body_ref = body # body_ref set to entered landscape
				create_preview()
	if body is DeckList:
		in_deck_list = true
		card.body_ref = body


func create_preview():
	if card.is_inside and drag_component.allow_drag:
		var sprite: Sprite2D = Sprite2D.new() # create new sprite
		sprite.set_name("card_preview") # set more readable name in scene tree
		card.body_ref.add_child(sprite) # add new sprite as child of the entered landscape
		var sub_viewport: SubViewport = %SubViewport # Used to Render the Card again
		var img: Image = sub_viewport.get_viewport().get_texture().get_image() # Retrieve the captured Image using get_image().
		var tex: ImageTexture = ImageTexture.create_from_image(img) 		# Convert Image to ImageTexture.
		sprite.texture = tex # Set sprite texture.
		sprite.scale = Vector2(.25, .25) # scale down
		sprite.modulate.a = 0.5 # make transparent


func remove_preview(_body):
	for droppable in get_tree().get_nodes_in_group("droppable"):
		if droppable.get_node_or_null("card_preview"): # If a preview exists
			droppable.get_node("card_preview").queue_free() # delete preview
