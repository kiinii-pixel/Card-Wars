class_name State extends Node


@warning_ignore("unused_signal")
signal Transitioned
@onready var card : Card = get_owner()
@onready var drag_component : Node2D = get_owner().get_node("drag_component")


func enter():
	pass


func exit():
	pass


func update(_delta : float):
	pass


func physics_update(_delta : float):
	pass
