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


func load_card(): # set the cards stats, name etc. to whatever is stored in its resource
	set_name(data.card_name) # sets name in the debug editor (instead of Node2D@1)
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
	while data.card_name.length() > max_characters: # if name is too long, scale it down
				%CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 1
				font_size -= 1.15


func load_image():
	# Load Image
	var card_image_path : String = "res://assets/images/cards/art/" + data.landscape + \
	"/" + data.card_type + "/" + data.card_name + ".png"
	if FileAccess.file_exists(card_image_path):
		%CardImage.texture = load(card_image_path)
	else:
		print("No Image Texture found")


func load_values(): # reload card values and changes colors
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
	set_name(data.card_name) # sets name in the debug editor (instead of Node2D@1)
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


func _on_drag_component_body_entered(body):
	if body is Landscape:
		for zones in body.get_parent().get_parent().get_children(): # Loop Zones Node
			for landscapes in zones.get_children(): # Loop through Landscapes (Children of Landscapes and EnemyLandscapes Node)
				if landscapes.get_child_count() >= 4: # If there's a preview or a card already
					if landscapes.get_node_or_null("card_preview"): # If a preview exists
						landscapes.get_node("card_preview").queue_free() # delete preview
		if body.get_child_count() == 3: # If landscape is empty
			is_inside = true # card is now inside a landcape
			body_ref = body # body_ref set to entered landscape

			# spawn card copy / indicator / Preview:
			# If card is inside a landscape (that is empty) and hasn't been played (so it doesnt spawn  preview on its way to discard pile)
			if is_inside and drag_component.allow_drag:
				var sprite = Sprite2D.new() # create new sprite
				sprite.set_name("card_preview") # set more readable name in scene tree
				body_ref.add_child(sprite) # add new sprite as child of the entered landscape
				var sub_viewport = %SubViewport # Used to Render the Card again
				var img = sub_viewport.get_viewport().get_texture().get_image() # Retrieve the captured Image using get_image().
				var tex = ImageTexture.create_from_image(img) 		# Convert Image to ImageTexture.
				sprite.texture = tex # Set sprite texture.
				sprite.scale = Vector2(0.5, 0.5) # scale down
				sprite.modulate.a = 0.5 # make transparent
	elif body is StaticBody2D:
		print("entered")


func _on_drag_component_body_exited(landscape: Landscape):
	if body_ref == landscape:
		is_inside = false
		#if body ref = body exited
		#landscape.get_child(3).queue_free()
		if landscape.get_node_or_null("card_preview"):
			landscape.get_node("card_preview").queue_free()


func flip():
	if state_mashine.current_state == state_mashine.states["in_deck"]:
		get_node("%AnimationPlayer").play("flip_up")
	elif state_mashine.current_state == state_mashine.states["in_deck"]:
		get_node("%AnimationPlayer").play("flip_down")
