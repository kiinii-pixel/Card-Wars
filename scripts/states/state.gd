class_name State extends Node


signal Transitioned
@onready var card : Card = get_owner()
@onready var drag_component = get_owner().get_node("drag_component")


func enter():
	pass


func exit():
	pass


func update(_delta : float):
	pass


func physics_update(_delta : float):
	pass
