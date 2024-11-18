extends Node2D


var selected : bool = false # true when mouse is hovering over card
#var mouse_offset : Vector2 = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position
var allow_drag : bool = true # This is set true when drawn and to false when the card is played

const SCALE_NORMAL = Vector2(1, 1)
const SCALE_ZOOMED = Vector2(1.2, 1.2)
 

func _ready():
	get_parent().z_index = 4


func _process(_delta):
	if allow_drag and selected:
		if Input.is_action_just_pressed("action_key"): # When the button press occurs
			initial_pos = get_parent().global_position
			await move(get_global_mouse_position(), 0.05) # Move to mouse position

		if Input.is_action_pressed("action_key"): # While button is pressed
			follow_mouse()


func follow_mouse():
	get_parent().global_position = get_global_mouse_position()


func scale_up(time):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(get_parent(), "scale", SCALE_ZOOMED, time)


func scale_down(time):
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(get_parent(), "scale", SCALE_NORMAL, time)


func move(destination : Vector2, time : float):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(get_parent(), "global_position", destination, time)
	await tween.finished
