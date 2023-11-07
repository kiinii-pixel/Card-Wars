extends Node2D

var attack = 1
var defense = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/Attack_Label.text = String.num_int64(attack)
	$Sprite2D/Defense_Label.text = String.num_int64(defense)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
