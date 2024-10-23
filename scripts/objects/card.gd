# Base Script for any Card
class_name Card extends Control

@export var data : Resource # Contains a Card Resource with its values

var body_ref : Landscape # Reference to the Landscape you're hovering over.
var is_inside = false # true if card is inside a landscape
@onready var drag_component : Object = $drag_component # drag component node
@onready var floop_component : Object = $floop_component
@onready var state_mashine = $state_mashine

var atk : int # dynamic values
var def : int
var cost : int


func _ready():
	load_card() # load card image and text
	z_index = 4 # z_index is initialized as 4. Elements on top are set to 5.

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
				font_size -= 1.15

# Load Card Image
func load_image():
	if data.image:
		%CardImage.texture = data.image
		return data.image
	else:
		print("No Image Texture found")

# Reload Values (Atk, Def, Cost) and change color.
func load_values():
	%CostLabel.text = String.num(cost)
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

# Flip Card face up or down
func flip():
	if state_mashine.current_state == state_mashine.states["in_deck"]:
		get_node("%AnimationPlayer").play("flip_up")
	elif state_mashine.current_state == state_mashine.states["in_deck"]:
		get_node("%AnimationPlayer").play("flip_down")
