extends Node


var CardData = {}
var data_file_path = "res://Data/all_cards.json"

func _ready():
	CardData = load_json_file(data_file_path)

func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Array:
			print("JSON file read in successfully.")
			return parsedResult
		else:
			print("error reading file")
	else:
		print("doesnt exist")
