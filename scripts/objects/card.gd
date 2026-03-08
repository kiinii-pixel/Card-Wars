# Base Script for any Card
class_name Card extends Control

@export var data : Resource # Contains a Card Resource with its values

var body_ref : StaticBody2D # Reference to the Landscape you're hovering over.
var is_inside : bool = false # true if card is inside a landscape
var being_dragged : bool = false # true when this card is being dragged
var mouse_in : bool = false #  true if the mouse is inside this card
@onready var drag_component : Object = $drag_component # drag component node
@onready var floop_component : Object = $floop_component
@onready var state_mashine = $state_mashine

var atk : int # dynamic values
var def : int
var cost : int


func _ready():
	load_card() # load card image and text
	z_index = 4 # z_index is initialized as 4. Elements on top are set to 5.


func _physics_process(delta: float) -> void:
	drag_logic(delta)


func drag_logic(delta: float) -> void:
	move_shadow()
	if (mouse_in or being_dragged) and (Mousebrain.is_dragging == null or Mousebrain.is_dragging == self):
		if Input.is_action_pressed("action_key"):
			global_position = lerp(global_position, get_global_mouse_position() - (size / 2.0), 22.0 * delta)
			_change_scale(Vector2(1.4, 1.4))
			z_index = 5
			being_dragged = true
			Mousebrain.is_dragging = self
		else:
			_change_scale(Vector2(1.2, 1.2))
			being_dragged = false
			if Mousebrain.is_dragging == self:
				Mousebrain.is_dragging = null
		return
	
	z_index = 4
	_change_scale(Vector2(1, 1))
	

func move_shadow():
	%Shadow.position = Vector2(-12, 12). rotated(%CardFrame.rotation)


@export var angle_x_max: float = 10.0
@export var angle_y_max: float = 10.0
func _on_gui_input(event: InputEvent) -> void:
	# Don't compute rotation when moving the card
	if being_dragged : return
	if not event is InputEventMouseMotion : return
	
	# Handles rotation
	# Get local mouse pos
	var mouse_pos: Vector2 = get_local_mouse_position()
	#print("Mouse: ", mouse_pos)
	#print("Card: ", position + size)
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	#print("Lerp val x: ", lerp_val_x)
	#print("lerp val y: ", lerp_val_y)

	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(-angle_y_max, angle_y_max, lerp_val_y))
	print("Rot x: ", rot_x)
	print("Rot y: ", rot_y)
	
	$SubViewportContainer.material.set_shader_parameter("x_rot", rot_y)
	$SubViewportContainer.material.set_shader_parameter("y_rot", rot_x)


# Set the Card's Text Labels to the Stats store in its "data" Resource File
func load_card():
	set_name(data.card_name) # Set Debug Editor Name (instead of Node2D@1)
	%CardName.text = data.card_name
	%LandscapeCardType.text = data.landscape + " " + data.card_type
	%Description.text = data.description
	# Atk/Def (when creature)
	if data.card_type == "Creature":
		atk = data.atk
		def = data.def
	cost = data.cost
	load_values()
	load_image()
	%CardFrame.texture = data.frame
	# Adjust name size
	var max_characters : int = 12
	var font_size = %CardName.get_theme_font_size("font_size")
	while data.card_name.length() > max_characters: # if name is too long, scale it down
				%CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 1
				font_size -= 1.75

# Load Card Image
func load_image():
	if data.image:
		%CardImage.texture = data.image
		return data.image
	else:
		print("No Image Texture found")

# Reload Values (Atk, Def, Cost) and change color.
func load_values():
	%CostLabel.text = String.num_int64(cost)
	if data.card_type == "Creature":
		var atk_label = %AttackLabel
		var def_label = %DefenseLabel

		#region setting/adjusting the atk_label's text
		if atk_label.text != String.num_int64(atk): # Set atk_label to atk
			if String.num_int64(atk).length() > 1: # If atk has 2 digits
				atk_label.add_theme_font_size_override("font_size", 58)
			else:
				atk_label.remove_theme_font_size_override("font_size")
			atk_label.text = String.num_int64(atk)
			if int(atk_label.text) < data.atk: # If attack is lower than default
				atk_label.add_theme_color_override("font_color", Color(1, 0, 0))
			elif int(atk_label.text) > data.atk: # If attack is higher than default
				atk_label.add_theme_color_override("font_color", Color(0, 1, 0))
		#endregion

		#region setting/adjusting the def_label's text
		if def_label.text != String.num_int64(def):
			if String.num_int64(def).length() > 1:
				def_label.add_theme_font_size_override("font_size", 58)
			else:
				def_label.remove_theme_font_size_override("font_size")
			def_label.text = String.num_int64(def)
			if int(def_label.text) < data.def:
				def_label.add_theme_color_override("font_color", Color(1, 0, 0))
			elif int(def_label.text) > data.def:
				def_label.add_theme_color_override("font_color", Color(0, 1, 0))
		#endregion

	else:
		%AttackLabel.text = ""
		%DefenseLabel.text = ""

# Reset Values to default
func reset_values():
	set_name(data.card_name) # Sets Debug Editor name (instead of Node2D@1)
	# Atk/Def (when creature)
	if data.card_type == "Creature":
		atk = data.atk
		%AttackLabel.text = String.num_int64(atk)
		%AttackLabel.remove_theme_color_override("font_color")

		def = data.def
		%DefenseLabel.text = String.num_int64(def)
		%DefenseLabel.remove_theme_color_override("font_color")

	cost = data.cost
	%CostLabel.text = String.num_int64(cost)

# When Card enteres a Physics body
func _on_drag_component_body_exited(body):
	if body_ref == body:
		is_inside = false
		if body.get_node_or_null("card_preview"):
			body.get_node("card_preview").queue_free()

# Flip Card face up
func flip_up():
	get_node("%AnimationPlayer").play("flip_up")

# Flip Card face down
func flip_down():
	get_node("%AnimationPlayer").play("flip_down")


func _on_mouse_entered() -> void:
	mouse_in = true
	print("mouse entered")


func _on_mouse_exited() -> void:
	mouse_in = false


var current_goal_scale : Vector2 = Vector2(1, 1)
var scale_tween : Tween
func _change_scale(desired_scale : Vector2):
	if desired_scale == current_goal_scale:
		return
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	scale_tween.tween_property(self, "scale", desired_scale, 0.125)
	
	current_goal_scale = desired_scale
