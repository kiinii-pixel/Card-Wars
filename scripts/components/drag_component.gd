extends Node2D

var selected : bool = false # true after mouse hovered over object
var mouse_offset : Vector2 = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position
var allow_drag : bool = true # This is set true when drawn and to false when the card is played
const SCALE_NORMAL = Vector2(0.25, 0.25)
const SCALE_ZOOMED = Vector2(0.3, 0.3)
 
func _ready():
	get_parent().z_index = 4

func _process(_delta):
	if allow_drag and selected:
		if Input.is_action_just_pressed("action_key"): # When the button press occurs
			Global.is_dragging = true
			mouse_offset = get_parent().position - get_global_mouse_position()
			initial_pos = get_parent().global_position
			await move(get_global_mouse_position(), 0.05) # Move to mouse position

		if Input.is_action_pressed("action_key"): # While button is pressed
			follow_mouse()

		elif Input.is_action_just_released("action_key"):
			Global.is_dragging = false
			scale_down(0.1)
			if get_parent() is Card:
				if get_parent().is_inside and selected and allow_drag: # If the card is released/placed inside a Landscape
					get_parent().play_card()
				elif selected and allow_drag: # when released anywherere else:
					move(initial_pos, 0.2) # go back

func _on_mouse_entered(): # when you hover over the card
	if not Global.is_dragging and allow_drag: # If no other card is being dragged:
		if get_parent() is Card:
			for child in get_parent().get_parent().get_children(): #scale all cards in hand down (only one scaled at a time)
				if child.z_index == 5:
					child.z_index = 4
					child.drag_component.scale_down(0.1)
					child.drag_component.selected = false
		selected = true # Select current card
		scale_up(0.2) # Scale up current card
		get_parent().z_index = 5

func _on_mouse_exited():
	if not Global.is_dragging and allow_drag:
		selected = false

	# If the card hasn't been scaled down yet. allow_drag has to be ture,
	# so the card doesnt scale down during it being placed onto a landscape.
	if get_parent().scale != SCALE_NORMAL and allow_drag:
		scale_down(0.1)
	get_parent().z_index = 4

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
