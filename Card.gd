extends Node2D

@export var cost = 1
var attack = 1
var defense = 2
@export var card_type = ['Creature', 'Building', 'Spell']
var landscape
var floop
var zone

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/Attack_Label.text = String.num_int64(attack)
	$Sprite2D/Defense_Label.text = String.num_int64(defense)
	$Sprite2D/Cost_Label.text = String.num_int64(cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
