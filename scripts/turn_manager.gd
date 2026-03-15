extends Node2D

var actions : int = 2


func _ready():
	Global.turn_manager = self


func end_turn():
	actions = 2


func can_play_card(cost : int) -> bool:
	return actions >= cost


func use_actions(amount : int):
	if actions >= amount:
		actions -= amount
