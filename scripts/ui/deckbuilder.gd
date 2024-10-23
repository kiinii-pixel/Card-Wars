extends Control

@onready var preloader = $ResourcePreloader
const CARD : PackedScene = preload("res://scenes/objects/card.tscn")

func _ready():
	load_cards()


func load_cards():
	var list = preloader.get_resource_list()
	for instance in list:
		create_card(instance)


func create_card(instance):
	var card = CARD.instantiate()
	card.data = preloader.get_resource(instance)
	card.load_image()
	if card.get_node("%CardImage").texture != null:
		$ScrollContainer/GridContainer.add_child(card)
		card.state_mashine.current_state = card.state_mashine.states["in_deck"]
	else:
		card.queue_free()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
