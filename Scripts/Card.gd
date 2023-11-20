extends Node2D

#example attributes
var cost = 1
var attack = 1
var defense = 2
var card_type = "Creature"
var landscape = "BluePlains"

#keeps track of whether a card is selected (being dragged)
var selected = false #true after click occcured on card
var mouse_offset = Vector2(0, 0)
var played = false #true when put on landscape
var draggable = false #true is mouse is hovering over card
var body_ref
var initial_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	#replace placeholders with the cards actual values
	#get_node("CardImage/Text/CCAttack/AttackLabel").text = String.num_int64(attack) same as:
	$CardImage/CCAttack/AttackLabel.text = String.num_int64(attack)
	$CardImage/CCDefense/DefenseLabel.text = String.num_int64(defense)
	$CardImage/CCCost/CostLabel.text = String.num_int64(cost)

func _process(_delta):
	#if player is clicking, set the card to mouse position
	if draggable:

		if Input.is_action_pressed("left_click") and selected and not played:
			position = get_global_mouse_position() + mouse_offset #keep card on mouse pos

		if Input.is_action_just_pressed("left_click"):
			Global.is_dragging = true
			initial_pos = global_position

		elif Input.is_action_just_released("left_click"):
			Global.is_dragging = false
			var tween = create_tween() #why get_tree()?  before: var tween = get_tree().create_tween()

			if Global.is_inside:
				tween.tween_property(self, "global_position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT) # CRASHES HERE BECAUSE position is NIL for some reason
				played = true
				scale = Vector2(0.5, 0.5)
			else:
				tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_IN)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

		if event.pressed:
			mouse_offset = position - get_global_mouse_position() #save the mouse offset
			selected = true           #these 2 kinda do the same thing, maybe i can make selected an
			Global.is_dragging = true #export var so other objects can still see the variable.
			#scale = Vector2(0.6, 0.6)

		else:
			selected = false  #when buttin is release, reverse everything
			Global.is_dragging = false 
			#scale = Vector2(0.5, 0.5)

func _on_area_2d_mouse_entered(): #when you hover over the card

	if not Global.is_dragging: #if no other card is being dragged:
		draggable = true #this card is now draggable
		z_index += 1

		if not played:
			#scale up (card zoom)
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.1).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited(): #reverses everything from above

	if not Global.is_dragging:
		draggable = true #should't this be false?
		z_index -= 1

		if not played:
			#scale down
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body:StaticBody2D): #when the card enters a static body

	if body.is_in_group('droppable'):
		Global.is_inside = true #if they overlap
		body_ref = body #current body

func _on_area_2d_body_exited(body): #when card leaves current body
	
	if body.is_in_group('droppable'):
		Global.is_inside = false
