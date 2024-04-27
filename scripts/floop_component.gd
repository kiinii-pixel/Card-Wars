extends Node2D

var selected = false # true after mouse hovered over object
var flooped = false

func _ready():
	pass

func _process(_delta):
	if selected and get_parent().played and not flooped:
		if Input.is_action_just_pressed("floop"):
			print("floop")
			get_parent().rotation_degrees = 90
			get_parent().position.y += 100
			flooped = true

func _on_mouse_entered(): # when you hover over the card
	selected = true

func _on_mouse_exited():
	selected = false
	
#func rotate(destination : Vector2, time : float):
#	var tween = create_tween().set_parallel()
#	tween.tween_property(get_parent(), "global_position", destination, time).set_ease(Tween.EASE_OUT)
#	await tween.finished
