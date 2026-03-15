extends Node2D

var empty : bool = true

func _on_child_order_changed() -> void:
	if get_child_count() == 3:
		empty = false
	if get_child_count() == 2:
		empty = true
