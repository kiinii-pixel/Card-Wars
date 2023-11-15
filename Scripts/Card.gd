extends Node2D

#example attributes
var cost = 1
var attack = 1
var defense = 2
var card_type = ['Creature', 'Building', 'Spell']
var landscape
var floop
var zone

#keeps track of whether a card is selected (being dragged)
var selected = false
var mouse_offset = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	#replace placeholders with the cards actual values
	#get_node("CardImage/Text/CCAttack/AttackLabel").text = String.num_int64(attack) same as:
	$CardImage/Text/CCAttack/AttackLabel.text = String.num_int64(attack)
	$CardImage/Text/CCDefense/DefenseLabel.text = String.num_int64(defense)
	$CardImage/Text/CCCost/CostLabel.text = String.num_int64(cost)


func _process(_delta):
	if Input.is_action_pressed("left_click") and selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position() + mouse_offset


func _on_area_2d_mouse_entered():
	selected = true


func _on_area_2d_mouse_exited():
	selected = false
