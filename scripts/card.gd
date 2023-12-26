class_name Card extends Node2D

@export var card_id = 7 # change to id of card you want
# VARIABLES FOR DRAGGING
var selected = false # true after mouse hovered over card
var mouse_offset = Vector2(0, 0) # save where the mouse clicked on the card
var played = false # true when dragged into play
var body_ref : Landscape # reference to object that was hovered over (e.g. landscape) // : Object if other zones are implemented
var initial_pos : Vector2 # save the cards initial position
var is_inside = false # true if card is inside a landscape

func _ready():
	load_card()
	z_index = 4

func _process(_delta):
	if selected and not played:
		if Input.is_action_just_pressed("left_click"): # Right when the click occurs
			Global.is_dragging = true
			initial_pos = global_position # Safe the cards initial position

		if Input.is_action_pressed("left_click"):
			follow_mouse() # Keep card on mouse pos
			
		elif Input.is_action_just_released("left_click"):
			Global.is_dragging = false
			var tween = create_tween().set_parallel()
			if is_inside:
				tween.tween_property(self, "global_position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT)
				tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2).set_ease(Tween.EASE_OUT)
				played = true
				await tween.finished
				scale = Vector2(1, 1)
				get_parent().card_played.emit()
				get_parent().remove_child(self)
				body_ref.add_child(self)
				position = Vector2(0, 0)
				#played = true
			else:
				tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_IN)

func follow_mouse():
	if z_index == 5:
		position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

		if event.pressed:
			mouse_offset = position - get_global_mouse_position() #save the mouse offset
			Global.is_dragging = true

		else:
			Global.is_dragging = false

func _on_area_2d_mouse_entered(): # when you hover over the card

	if not Global.is_dragging and not played: #if no other card is being dragged:
		#if get_parent().get_child_count() > 0:
		for child in get_parent().get_children():
			if child.z_index == 5:
				child.z_index = 4
			var tween = create_tween()
			tween.tween_property(child, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)
			selected = false

		selected = true
		z_index = 5 # raise z index of this card

		if not played:
			# Scale up (card zoom)
			var tween = create_tween().set_parallel(true)
			tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.1).set_ease(Tween.EASE_IN)
			#tween.tween_property(self, "position", position + Vector2(0, -50), 0.1).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited(): # reverses everything from above

	Global.is_dragging = false
	selected = false
	z_index = 4

	if played == false:
		# Scale down
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)
		#tween.tween_property(self, "position", position + Vector2(0, 50), 0.1).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(landscape: Landscape): # when the card enters a landscape
	body_ref = landscape # current body
	if landscape.get_child_count() == 4:
		is_inside = true # if they overlap

func _on_area_2d_body_exited(landscape: Landscape): # when card leaves current body
	if body_ref == landscape:
		is_inside = false
		#if body ref = body exited

func load_card():
	#LOAD CARD DATA
	var card_data = StaticData.return_data() # all data
	var landscape = card_data[card_id].get("landscape") # landscape (e.g. 'Blue Plains')
	var card_type = card_data[card_id].get("card_type") # card type (e.g. 'Creature')
	var card_description = card_data[card_id].get("description")

	var jpg = card_data[card_id].get("image_name") # original name (.jpg)
	var card_name = jpg.left(jpg.length() - 4) # card name without file extension
	
	var card_image_path = "res://assets/images/cards/art/" + landscape + "/" + card_type + "/" + card_name + ".png"
	var frame_path = "res://assets/images/frames" + landscape + ".png"
	
	if card_type == "Creature":
		frame_path = "res://assets/images/frames/" + landscape + "_Creature.png"

	var attack_value = String.num(card_data[card_id].get("atk"))
	var defense_value = String.num(card_data[card_id].get("def"))
	var cost_value = String.num(card_data[card_id].get("cost"))

	$CardFrame.texture = load(frame_path)
	$CardImage.texture = load(card_image_path)

	$CardFrame/CCAttack/AttackLabel.text = attack_value
	if defense_value.length() > 1:
		$CardFrame/CCDefense/DefenseLabel.add_theme_font_size_override("font_size", 56)
	$CardFrame/CCDefense/DefenseLabel.text = defense_value
	$CardFrame/CostLabel.text = cost_value
	$Labels/CardName.text = card_name
	var max_characters = 12
	var font_size = 20
	while card_name.length() > max_characters:
				$Labels/CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 4
				font_size -= 1
	
	$Labels/LandscapeCardType.text = landscape + card_type
	$Labels/Description.text = card_description
