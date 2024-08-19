extends Node2D

@export var card_name : String

func load_card(): # set the cards stats, name etc. to whatever is stored in its resource
	var resource_path : String = "res://data/cards/" + card_name + ".tres"
	var data : Resource = load(resource_path) # load card resource
	set_name(card_name) # sets name in the debug editor (instead of Node2D@1)
	%CardName.text = data.card_name
	%LandscapeCardType.text = data.landscape + " " + data.card_type
	%Description.text = data.description
	# Atk/Def (when creature)
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

