extends Node2D


var selected : bool = false # true when mouse is hovering over card
#var mouse_offset : Vector2 = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position
var allow_drag : bool = true # This is set true when drawn and to false when the card is played

const SCALE_NORMAL = Vector2(0.25, 0.25)
const SCALE_ZOOMED = Vector2(0.3, 0.3)
 

func _ready():
	get_parent().z_index = 4


func _process(_delta):
	if allow_drag and selected:
		if Input.is_action_just_pressed("action_key"): # When the button press occurs
			initial_pos = get_parent().global_position
			await move(get_global_mouse_position(), 0.05) # Move to mouse position

		if Input.is_action_pressed("action_key"): # While button is pressed
			follow_mouse()

# when you hover over the card
func _on_mouse_entered():
	print("mouse_entered")
	if not Global.is_dragging and allow_drag: # If no other card is being dragged:
		selected = true # Select current card
		print("selected")
		scale_up(0.2) # Scale up current card


func _on_mouse_exited():
	if not Global.is_dragging and allow_drag:
		selected = false

	# If the card hasn't been scaled down yet. allow_drag has to be ture,
	# so the card doesnt scale down during it being placed onto a landscape.
	# selected has to be false, so it doesn't happen on the card you're dragging
	if get_owner().scale != SCALE_NORMAL and allow_drag and not selected:
		scale_down(0.2)
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
