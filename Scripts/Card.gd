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

# Called when the node enters the scene tree for the first time.
func _ready():
	#replace placeholders with the cards actual values
	#get_node("CardImage/Text/CCAttack/AttackLabel").text = String.num_int64(attack) same as:
	$CardImage/CCAttack/AttackLabel.text = String.num_int64(attack)
	$CardImage/CCDefense/DefenseLabel.text = String.num_int64(defense)
	$CardImage/CCCost/CostLabel.text = String.num_int64(cost)


func _process(_delta):
	if Input.is_action_pressed("left_click") and selected:
		position = get_global_mouse_position()

#func followMouse():
#	position = get_global_mouse_position()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
			Global.is_dragging = true
		else:
			selected = false
			Global.is_dragging = false

func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(0.6, 0.6)

func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(0.5, 0.5)

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('droppable'):
		is_inside = true
		body.modulate = Color(Color.GREEN_YELLOW, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('droppable'):
		is_inside = false
		body.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)
