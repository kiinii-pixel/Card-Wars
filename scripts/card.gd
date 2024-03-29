class_name Card extends Node2D

@onready var card_sound = $card_sound
@export var card_name : String # change to card you want
# CARD VARIABLES
var played = false # true when dragged into play // drag_component.allow_drag should be enough
var body_ref : Landscape # reference to object that was hovered over (e.g. landscape)
var is_inside = false # true if card is inside a landscape
var drag_component : Object # drag component node

var atk : int
var def : int
var cost : int

func _ready():
	load_card() # load card image and text
	z_index = 4 # z_index is initialized as 4. Elements on top are set to 5.
	drag_component = $drag_component

func _process(_delta):
	if Input.is_action_just_released("action_key"): # When button is released
		if is_inside and drag_component.selected: # If the card is released/placed inside a Landscape
			play_card()

		elif drag_component.selected and not played:
			drag_component.move(drag_component.initial_pos, 0.2)

func play_card():
	drag_component.allow_drag = false
	Global.is_dragging = false
	played = true
	is_inside = false
	drag_component.scale_down(0.2)
	await drag_component.move(body_ref.global_position, 0.2)
	reparent(body_ref)
	position = Vector2(0, 0)
	scale = Vector2(0.5, 0.5)
	card_sound.play()

func _on_drag_component_mouse_entered(): # when you hover over the card
	if not played and !Global.is_dragging:
		for child in get_parent().get_children():
			if child.z_index == 5:
				child.z_index = 4
				child.drag_component.scale_down(0.1)
				child.drag_component.selected = false
		drag_component.scale_up(0.1)
		z_index = 5 # raise z index of this card
		drag_component.selected = true

func load_card():
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path)
	set_name(card_name) # sets name in the debug editor (instead of Node2D@1)
	%CardName.text = data.card_name
	%LandscapeCardType.text = data.landscape + " " + data.card_type
	%Description.text = data.description
	# Atk/Def (when creature)
	if data.card_type == "Creature":
		atk = data.atk
		def = data.def
	cost = data.cost
	load_values()
	# Load Image
	var card_image_path : String = "res://assets/images/cards/art/" + data.landscape + \
	"/" + data.card_type + "/" + data.card_name + ".png"
	%CardImage.texture = load(card_image_path)
	# Load Frame
	var frame_path : String
	if data.card_type == "Creature":
		frame_path = "res://assets/images/frames/" + data.landscape + "_Creature.png"
	else:
		frame_path = "res://assets/images/frames/" + data.landscape + ".png"
	%CardFrame.texture = load(frame_path)
	# Adjust name size
	var max_characters : int = 12
	var font_size = %CardName.get_theme_font_size("font_size")
	while card_name.length() > max_characters:
				%CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 1
				font_size -= 1.15

func load_values():
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path)
	%CostLabel.text = String.num(cost)
	if data.card_type == "Creature":
		if %AttackLabel.text != String.num_int64(atk):
			if String.num_int64(atk).length() > 1:
				%AttackLabel.add_theme_font_size_override("font_size", 58)
			else:
				%AttackLabel.remove_theme_color_override("font_size")
			%AttackLabel.text = String.num_int64(atk)
		if int(%AttackLabel.text) < data.atk:
			%AttackLabel.add_theme_color_override("font_color", Color(1, 0, 0))
		elif int(%AttackLabel.text) > data.atk:
			%AttackLabel.add_theme_color_override("font_color", Color(0, 1, 0))

		if %DefenseLabel.text != String.num_int64(def):
			if String.num_int64(def).length() > 1:
				%DefenseLabel.add_theme_font_size_override("font_size", 58)
			else:
				%DefenseLabel.add_theme_font_size_override("font_size", 78)
			%DefenseLabel.text = String.num_int64(def)
		if int(%DefenseLabel.text) < data.def:
			%DefenseLabel.add_theme_color_override("font_color", Color(1, 0, 0))
		elif int(%DefenseLabel.text) > data.def:
			%DefenseLabel.add_theme_color_override("font_color", Color(0, 1, 0))
	else:
		%AttackLabel.text = ""
		%DefenseLabel.text = ""

func _on_drag_component_body_entered(landscape: Landscape):
	#is_inside = false
	if landscape.get_child_count() == 3:
		is_inside = true # if they overlap
		body_ref = landscape # current body

func _on_drag_component_body_exited(landscape: Landscape):
	if body_ref == landscape:
		is_inside = false
		#if body ref = body exited
