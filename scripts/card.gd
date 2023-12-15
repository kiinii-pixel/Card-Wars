class_name Card extends Node2D

signal landscape_entered(landscape: Landscape)

var selected = false # true after click occcured on card
var mouse_offset = Vector2(0, 0)
var played = false # true when put on landscape
var body_ref
var initial_pos : Vector2
var is_inside = false
var card_id = 7

var hovered_cards : Array = []

func _ready():
#	load_image()
	pass

func _process(_delta):
	if selected:
		
		if Input.is_action_pressed("left_click") and not played:
			position = get_global_mouse_position() + mouse_offset #keep card on mouse pos

		if Input.is_action_just_pressed("left_click"):
			Global.is_dragging = true
			initial_pos = global_position

		elif Input.is_action_just_released("left_click"):
			Global.is_dragging = false
			var tween = create_tween() # why get_tree()?  before: var tween = get_tree().create_tween()

			if is_inside:
				tween.tween_property(self, "global_position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT) # CRASHES HERE BECAUSE position is NIL for some reason
				played = true
				scale = Vector2(0.5, 0.5)

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
			if hovered_cards.find(self) == -1:
				hovered_cards.append(self)
			
			if hovered_cards.size() > 0 and hovered_cards[hovered_cards.size() - 1] == self:
				#scale up (card zoom)
				var tween = create_tween()
				tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.1).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited(): # reverses everything from above

	selected = false
	z_index -= 1
	hovered_cards.erase(self)

	if not played:
		if hovered_cards.find(self) == -1:
			#scale down
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(landscape: Landscape): # when the card enters a landscape

	body_ref = landscape # current body
	is_inside = true # if they overlap

func _on_area_2d_body_exited(_landscape): # when card leaves current body
		is_inside = false

func load_image():
	var card_data = StaticData.return_data()
	
	var landscape = card_data[card_id].get("landscape")
	var card_type = card_data[card_id].get("card_type")
	
	var jpg_card_name = card_data[card_id].get("image_name")
	var card_name = jpg_card_name.left(jpg_card_name.length() - 4)
	
	var image_path = "res://assets/images/cards/modular_cards/" + landscape + "/" + card_type + "/" + card_name + ".png"
	
	$CardImage.texture = load(image_path)
	$CardImage/CCAttack/AttackLabel.text = String.num(card_data[card_id].get("atk"))
	$CardImage/CCDefense/DefenseLabel.text = String.num(card_data[card_id].get("def"))
	$CardImage/CCCost/CostLabel.text = String.num(card_data[card_id].get("cost"))

func _init(id):
	card_id = id
