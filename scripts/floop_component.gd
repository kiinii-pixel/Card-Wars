extends Node2D

var selected = false # true after mouse hovered over object
var flooped = false
var attacked = false

func _ready():
	pass

func _process(_delta):
	if selected and get_parent().played and not flooped or attacked:
		if Input.is_action_just_pressed("floop"):
			#get_parent().rotation_degrees = 90
			rotate_card(Vector2(0, 100), 90, 0.25)
			flooped = true
		elif Input.is_action_just_pressed("attack"):
			rotate_card(Vector2(0, -100), -90, 0.25)
			attacked = true

func _on_mouse_entered(): # when you hover over the card
	selected = true

func _on_mouse_exited():
	selected = false
	
func rotate_card(move_amount : Vector2, rotation_amount : int, time : float):
	var tween = create_tween().set_parallel()
	tween.tween_property(get_parent(), "rotation_degrees", rotation_amount, time).set_ease(Tween.EASE_OUT)
	tween.tween_property(get_parent(), "position", position - move_amount, time).set_ease(Tween.EASE_OUT)
	await tween.finished
