extends Node2D

var selected = false # true after mouse hovered over object
var mouse_offset = Vector2(0, 0) # save where the mouse clicked on the object
var initial_pos : Vector2 # save the cards initial position

func _ready():
	get_parent().z_index = 4

func _process(_delta):
		if Input.is_action_just_pressed("action_key") and selected: # Right when the click occurs
			Global.is_dragging = true
			initial_pos = global_position # Safe the cards initial position
			var tween = create_tween()
			tween.tween_property(get_parent(), "global_position", get_global_mouse_position(), 0.05).set_ease(Tween.EASE_OUT)

		if Input.is_action_pressed("action_key"):
			if get_parent().z_index == 5 and selected:
				get_parent().global_position = get_global_mouse_position() #+ mouse_offset # Keep card on mouse pos
			
		elif Input.is_action_just_released("action_key"):
			Global.is_dragging = false
			var tween = create_tween().set_parallel()
			tween.tween_property(get_parent(), "scale", Vector2(0.5, 0.5), 0.2).set_ease(Tween.EASE_OUT)
			await tween.finished

func _on_input_event(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position() #save the mouse offset

func _on_mouse_entered(): # when you hover over the card
	if not Global.is_dragging: #if no other card is being dragged:
#		for child in get_parent().get_children(): # Move other cards to back and scale down
#			if child.z_index == 5:
#				child.z_index = 4
#			var tween = create_tween()
#			tween.tween_property(child, "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)
#			selected = false

		selected = true
		get_parent().z_index = 5 # raise z index of this card
		print("registering mouse entered")

		# Scale up (card zoom)
		var tween = create_tween().set_parallel(true)
		print(123)
		tween.tween_property(get_parent(), "scale", Vector2(0.65, 0.65), 0.1).set_ease(Tween.EASE_IN)
		#tween.tween_property(self, "position", position + Vector2(0, -50), 0.1).set_ease(Tween.EASE_IN)

func _on_mouse_exited():
	if Global.is_dragging == false:
		selected = false
		z_index = 4
		# Scale down
		var tween = create_tween().set_parallel(true)
		tween.tween_property(get_parent(), "scale", Vector2(0.5, 0.5), 0.1).set_ease(Tween.EASE_OUT)
		#tween.tween_property(self, "position", position + Vector2(0, 50), 0.1).set_ease(Tween.EASE_OUT)
