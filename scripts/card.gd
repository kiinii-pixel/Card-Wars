class_name Card extends Node2D

@export var card_id : int # change to id of card you want
# CARD VARIABLES
var played = false # true when dragged into play // drag_component.allow_drag should be enough
var body_ref : Landscape # reference to object that was hovered over (e.g. landscape)
# : Object if other zones are implemented
var is_inside = false # true if card is inside a landscape
var drag_component : Object # drag component node

func _ready():
	load_card() # load card image and text
	z_index = 4 # z_index is initialized as 4. Elements on top are set to 5.
	drag_component = get_node("drag_component")

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
	get_parent().remove_child(self)
	body_ref.add_child(self)
	position = Vector2(0, 0)
	scale = Vector2(0.5, 0.5)

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

func _on_drag_component_mouse_exited(): # reverses everything from above
	pass

func load_card():
	#LOAD CARD DATA
	var card_data = StaticData.return_data() # all data
	var landscape = card_data[card_id].get("landscape") # landscape (e.g. 'Blue Plains')
	var card_type = card_data[card_id].get("card_type") # card type (e.g. 'Creature')
	var card_description = card_data[card_id].get("description")

	var jpg = card_data[card_id].get("image_name") # original name (.jpg)
	var card_name = jpg.left(jpg.length() - 4) # card name without file extension
	
	var card_image_path = "res://assets/images/cards/art/" + landscape + "/" \
	+ card_type + "/" + card_name + ".png"
	
	var frame_path
	if card_type == "Creature":
		frame_path = "res://assets/images/frames/" + landscape + "_Creature.png"
	else:
		frame_path = "res://assets/images/frames/" + landscape + ".png"

	if card_data[card_id].get("cost"):
		var cost_value = String.num(card_data[card_id].get("cost"))
		%CostLabel.text = cost_value
	if card_type == "Creature":
		var attack_value = String.num(card_data[card_id].get("atk"))
		var defense_value = String.num(card_data[card_id].get("def"))
		
		if attack_value.length() > 1:
			%AttackLabel.add_theme_font_size_override("font_size", 58)
		%AttackLabel.text = attack_value
		if defense_value.length() > 1:
			%DefenseLabel.add_theme_font_size_override("font_size", 58)
		%DefenseLabel.text = defense_value

	%CardName.text = card_name

	%CardFrame.texture = load(frame_path)
	%CardImage.texture = load(card_image_path)

	var max_characters = 12
	var font_size = %CardName.get_theme_font_size("font_size")
	while card_name.length() > max_characters:
				%CardName.add_theme_font_size_override("font_size", font_size)
				max_characters += 1
				font_size -= 1.15

	%LandscapeCardType.text = landscape + card_type
	%Description.text = card_description

	set_name(card_name)

func _on_drag_component_body_entered(landscape: Landscape):
	#is_inside = false
	if landscape.get_child_count() == 3:
		is_inside = true # if they overlap
		body_ref = landscape # current body

func _on_drag_component_body_exited(landscape: Landscape):
	if body_ref == landscape:
		is_inside = false
		#if body ref = body exited
