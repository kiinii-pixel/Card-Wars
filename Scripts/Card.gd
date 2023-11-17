extends Node2D

#example attributes
var cost = 1
var attack = 1
var defense = 2
var card_type = ['Creature', 'Building', 'Spell']
var landscape

#keeps track of whether a card is selected (being dragged)
var selected = false

var draggable = false
var is_inside = false
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
		if Input.is_action_pressed("left_click") and selected: #selected is true if click occured in objects area2D
			position = get_global_mouse_position()
		if Input.is_action_just_pressed("left_click"):
			Global.is_dragging = true
			initial_pos = global_position
		elif Input.is_action_just_released("left_click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "position", initial_pos, 0.2).set_ease(Tween.EASE_IN)

#this is how they did in in the tutorial, although i don't see why you cant set the position in the process function,
#instead of calling this function. Maybe i will see why and make this function active again
#func followMouse():
#	position = get_global_mouse_position()


#When a click occurs on the are 2D, selected is set to true.
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true           #these 2 kinda do the same thing, maybe i can make selected an
			Global.is_dragging = true #export var so other objects can still see the variable.
			scale = Vector2(0.6, 0.6)
		else:
			selected = false  #when buttin is release, reverse everything
			Global.is_dragging = false 
			scale = Vector2(0.5, 0.5)

func _on_area_2d_mouse_entered(): #when you hover over the card
	if not Global.is_dragging: #if no other card is being dragged:
		draggable = true #this card is now draggable
		scale = Vector2(0.6, 0.6) #scale it up a little (visual effect)

func _on_area_2d_mouse_exited(): #reverses everything from above
	if not Global.is_dragging:
		draggable = true #should't this be false?
		scale = Vector2(0.5, 0.5)

func _on_area_2d_body_entered(body:StaticBody2D): #when the card enters a static body
	if body.is_in_group('droppable'):
		is_inside = true #if they overlap
		body.modulate = Color(Color.GREEN_YELLOW, 1) #change rect color of static body
		body_ref = body #current body
		print(body_ref)
		#Landscape:<StaticBody2D#25820136601> #working
#		StaticBody2D:<StaticBody2D#25836913819>

func _on_area_2d_body_exited(body): #when card leaves current body
	if body.is_in_group('droppable'):
		is_inside = false
		body.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7) #change color back
