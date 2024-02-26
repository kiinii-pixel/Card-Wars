extends Node

@export var stats : CardResource
var card_data : Array
var save_path : String

func _ready():
	print("Card Resource ready.")
	card_data = StaticData.return_data()

func initialize(card_id):
	stats.card_name = card_data[card_id].get("name")
	stats.atk = card_data[card_id].get("atk")
	stats.def = card_data[card_id].get("def")
	stats.ability = card_data[card_id].get("ability")
	stats.cost = card_data[card_id].get("cost")
	stats.description = card_data[card_id].get("description")
	stats.landscape = card_data[card_id].get("landscape")
	stats.card_type = card_data[card_id].get("card_type")
	stats.image = card_data[card_id].get("image_name")
	stats.id = card_data[card_id].get("card_id")

	save_path = "res://data/cards/" + stats.landscape + "/" + stats.card_type \
	+ "/" + stats.card_name + ".tres"

func create_resource() -> void:
	var save_result = ResourceSaver.save(stats, save_path)
	if save_result != OK:
		print(save_result)
