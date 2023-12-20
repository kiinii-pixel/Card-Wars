class_name Card extends Node2D

var selected = false # true after click occcured on card
var mouse_offset = Vector2(0, 0)
var played = false # true when put on landscape
var body_ref
var initial_pos : Vector2
var is_inside = false
@export var card_id = 7

func _ready():
	load_card()

func _process(_delta):
	if selected:
		if Input.is_action_just_pressed("left_click"): # Right when the click occurs
			Global.is_dragging = true
			initial_pos = global_position # Safe the cards initial position
		if Input.is_action_pressed("left_click") and not played:
			position = get_global_mouse_position() + mouse_offset # Keep card on mouse pos
			
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

func _on_area_2d_input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

		if event.pressed:
			mouse_offset = position - get_global_mouse_position() #save the mouse offset
			Global.is_dragging = true

		else:
			Global.is_dragging = false

func _on_area_2d_mouse_entered(): # when you hover over the card

	if not Global.is_dragging: #if no other card is being dragged:
		selected = true
		z_index += 1

		if not played:
			# Scale up (card zoom)
			var tween = create_tween().set_parallel(true)
			tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.1).set_ease(Tween.EASE_IN)
			#tween.tween_property(self, "position", position + Vector2(0, -50), 0.1).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited(): # reverses everything from above

	selected = false
	z_index -= 1

	if played == false:
		# Scale down
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)
		#tween.tween_property(self, "position", position + Vector2(0, 50), 0.1).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(landscape: Landscape): # when the card enters a landscape

	body_ref = landscape # current body
	is_inside = true # if they overlap

func _on_area_2d_body_exited(_landscape): # when card leaves current body
		is_inside = false

func load_card():
	var card_data = StaticData.return_data()
	
	var landscape = card_data[card_id].get("landscape")
	var card_type = card_data[card_id].get("card_type")
	
	var jpg_card_name = card_data[card_id].get("image_name")
	var card_name = jpg_card_name.left(jpg_card_name.length() - 4)
	var frame_path = "res://assets/images/cards/art/" + landscape + "/" + landscape + ".png"
	var card_image_path = "res://assets/images/cards/art/" + landscape + "/" + card_type + "/" + card_name + ".png"
	
	if card_type == "Creature":
		frame_path = "res://assets/images/cards/art/" + landscape + "/" + landscape + "_Creature.png"

	var attack_value = String.num(card_data[card_id].get("atk"))
	var defense_value = String.num(card_data[card_id].get("def"))
	var cost_value = String.num(card_data[card_id].get("cost"))

	$CardFrame.texture = load(frame_path)
	$CardImage.texture = load(card_image_path)
	$CardFrame/CCAttack/AttackLabel.text = attack_value
	if defense_value.length() > 1:
		$CardFrame/CCDefense/DefenseLabel.add_theme_font_size_override("font_size", 50)
	$CardFrame/CCDefense/DefenseLabel.text = defense_value
	$CardFrame/CostLabel.text = cost_value
