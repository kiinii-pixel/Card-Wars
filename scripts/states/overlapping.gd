class_name Overlapping extends State # Card is being dragged over a Landscape


func enter():
	pass

func update(_delta : float):
	if Input.is_action_just_released("action_key"):
		if Global.turn_manager and Global.turn_manager.can_play_card(card.cost):
			Global.turn_manager.use_actions(card.cost)
			Transitioned.emit(self, "in_play")
		else:
			drag_component.move(drag_component.initial_pos, 0.3) # go back
			card.position += Vector2(0, 50)
			card.rotation = card.hand_rotation
			Transitioned.emit(self, "in_hand")
			Global.is_dragging = false
	elif !card.is_inside:
		Transitioned.emit(self, "dragging")


func exit():
	remove_preview()


func remove_preview():
	for droppable in get_tree().get_nodes_in_group("droppable"):
		if droppable.get_node_or_null("card_preview"): # If a preview exists
			droppable.get_node("card_preview").queue_free() # delete preview
