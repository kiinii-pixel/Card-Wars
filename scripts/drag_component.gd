extends Node2D

var selected = false # true after mouse hovered over object
var mouse_offset = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position
var allow_drag = true

func _ready():
	get_parent().z_index = 4

func _process(_delta):
	if allow_drag:
		if Input.is_action_just_pressed("action_key") and selected: # Right when the click occurs
			mouse_offset = position - get_global_mouse_position() #save the mouse offset
			Global.is_dragging = true
			initial_pos = global_position # Safe the cards initial position
			var tween = create_tween()
			tween.tween_property(get_parent(), "global_position", get_global_mouse_position(), 0.05).set_ease(Tween.EASE_OUT)

		if Input.is_action_pressed("action_key"):
			if get_parent().z_index == 5 and selected:
				get_parent().global_position = get_global_mouse_position() #+ mouse_offset # Keep card on mouse pos
			
		elif Input.is_action_just_released("action_key"):
			Global.is_dragging = false
			scale_down(0.5, 0.1)

func _on_mouse_entered(): # when you hover over the card
	if not Global.is_dragging and allow_drag: #if no other card is being dragged:
		selected = true
		get_parent().z_index = 5 # raise z index of this card
		scale_up(0.65, 0.1)
		#tween.tween_property(self, "position", position + Vector2(0, -50), 0.1).set_ease(Tween.EASE_IN)

func _on_mouse_exited():
	if Global.is_dragging == false and allow_drag:
		selected = false
		z_index = 4
		# Scale down
		scale_down(0.5, 0.1)
		#tween.tween_property(self, "position", position + Vector2(0, 50), 0.1).set_ease(Tween.EASE_OUT)

func scale_up(x, time):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(get_parent(), "scale", Vector2(x, x), time).set_ease(Tween.EASE_IN)

func scale_down(x, time):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(get_parent(), "scale", Vector2(x, x), time).set_ease(Tween.EASE_OUT)
