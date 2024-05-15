extends Node2D

var selected = false # true after mouse hovered over object
var mouse_offset = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position
var allow_drag = false # This is set true when drawn and to false when the card is played
var SCALE_NORMAL = 0.25
var SCALE_ZOOMED = 0.3

func _ready():
	get_parent().z_index = 4
	#move(Vector2(0, 0), 5)

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

func _on_mouse_entered(): # when you hover over the card
	if not Global.is_dragging and allow_drag: # If no other card is being dragged:
		selected = true # Select current card
		scale_up(0.1) # Scale up current card
		get_parent().z_index = 5

func _on_mouse_exited():
	if not Global.is_dragging and allow_drag:
		selected = false

	# If the card hasn't been scaled down yet. allow_drag has to be ture,
	# so the card doesnt scale down during it being placed onto a landscape.
	if get_parent().scale != Vector2(0.25, 0.25) and allow_drag:
		scale_down(0.1)
	get_parent().z_index = 4

func follow_mouse():
	get_parent().global_position = get_global_mouse_position()

func scale_up(time):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(get_parent(), "scale", Vector2(SCALE_ZOOMED, SCALE_ZOOMED), time).set_ease(Tween.EASE_IN)

func scale_down(time):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(get_parent(), "scale", Vector2(SCALE_NORMAL, SCALE_NORMAL), time).set_ease(Tween.EASE_OUT)

func move(destination : Vector2, time : float):
	var tween = create_tween().set_parallel()
	tween.tween_property(get_parent(), "global_position", destination, time).set_ease(Tween.EASE_OUT)
	await tween.finished
