extends Node2D

var cost = 1
var attack = 1
var defense = 2
var card_type = ['Creature', 'Building', 'Spell']
var landscape
var floop
var zone

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("CardImage/Text/CCAttack/AttackLabel").text = String.num_int64(attack) //same as:
	$CardImage/Text/CCAttack/AttackLabel.text = String.num_int64(attack)
	$CardImage/Text/CCDefense/DefenseLabel.text = String.num_int64(defense)
	$CardImage/Text/CCCost/CostLabel.text = String.num_int64(cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
