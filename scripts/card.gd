class_name Card extends Node2D

@onready var card_sound = $card_sound
@export var card_name : String # change to card you want
# CARD VARIABLES
var played = false # true when dragged into play // drag_component.allow_drag should be enough
var body_ref : Landscape # reference to object that was hovered over (e.g. landscape)
var is_inside = false # true if card is inside a landscape
var drag_component : Object # drag component node
var floop_component : Object

var atk : int # dynamic values
var def : int
var cost : int

func _ready():
	load_card() # load card image and text
	z_index = 4 # z_index is initialized as 4. Elements on top are set to 5.
	# why not 0 and 1? because it didnt work..
	drag_component = $drag_component
	floop_component = $floop_component

func _process(_delta):
	if Input.is_action_just_released("action_key"): # When button is released
		if is_inside and drag_component.selected: # If the card is released/placed inside a Landscape
			play_card()

		elif drag_component.selected and not played: # when released anywherere else:
			drag_component.move(drag_component.initial_pos, 0.2) # go back

func play_card():
	drag_component.allow_drag = false # card can't be dragged anymore
	Global.is_dragging = false
	played = true
	is_inside = false
	drag_component.scale_down(0.2) # scale card back down
	await drag_component.move(body_ref.global_position, 0.2) # move to landscape
	reparent(body_ref) # reparent to the landscape it was played on
	position = Vector2(0, 0)
	scale = Vector2(0.5, 0.5)
	card_sound.play()

func _on_drag_component_mouse_entered(): # when you hover over the card
	if not played and !Global.is_dragging and drag_component.allow_drag:
		for child in get_parent().get_children(): #scale all cards down (only one scaled at a time)
			if child.z_index == 5:
				child.z_index = 4
				child.drag_component.scale_down(0.1)
				child.drag_component.selected = false
		drag_component.scale_up(0.1) # scale new selected card up
		z_index = 5 # raise z index of this card
		drag_component.selected = true

func load_card(): # set the cards stats, name etc. to whatever is stored in its resource
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path) # load card resource
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
	while card_name.length() > max_characters: # if name is too long, scale it down
				%CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 1
				font_size -= 1.15

func load_values(): # reload card values and changes colors
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path)
	%CostLabel.text = String.num(cost)
	if data.card_type == "Creature":
		var atk_label = %AttackLabel
		var def_label = %DefenseLabel
		if atk_label.text != String.num_int64(atk):
			if String.num_int64(atk).length() > 1:
				atk_label.add_theme_font_size_override("font_size", 58)
			else:
				atk_label.remove_theme_font_size_override("font_size")
			atk_label.text = String.num_int64(atk)
		if int(atk_label.text) < data.atk:
			atk_label.add_theme_color_override("font_color", Color(1, 0, 0))
		elif int(atk_label.text) > data.atk:
			atk_label.add_theme_color_override("font_color", Color(0, 1, 0))

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
	else:
		%AttackLabel.text = ""
		%DefenseLabel.text = ""

func reset_values():
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path) # load card resource
	set_name(card_name) # sets name in the debug editor (instead of Node2D@1)
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

func _on_drag_component_body_entered(landscape : Landscape):
	for zones in landscape.get_parent().get_parent().get_children(): # Loop through landscapes
		for landscapes in zones.get_children():
			if landscapes.get_child_count() >= 4: # If there's a preview
				if landscapes.get_node_or_null("card_preview"):
					landscapes.get_node("card_preview").queue_free()
	if landscape.get_child_count() == 3:
		is_inside = true # if they overlap
		body_ref = landscape # current body

		#Get Landscapes. Remove Sprite

		#spawn card copy / indicator:
		if is_inside:
			var sprite = Sprite2D.new()
			sprite.set_name("card_preview")
			landscape.add_child(sprite)
			var sub_viewport = %SubViewport # Used to Render the Card again
			var img = sub_viewport.get_viewport().get_texture().get_image() # Retrieve the captured Image using get_image().
			var tex = ImageTexture.create_from_image(img) 		# Convert Image to ImageTexture.
			sprite.texture = tex # Set sprite texture.
			sprite.scale = Vector2(0.5, 0.5)
			sprite.modulate.a = 0.5
		

func _on_drag_component_body_exited(landscape: Landscape):
	if body_ref == landscape:
		is_inside = false
		#if body ref = body exited
		#landscape.get_child(3).queue_free()
		if landscape.get_node_or_null("card_preview"):
			landscape.get_node("card_preview").queue_free()
