extends Node


#var dict = {}

func _ready():
	pass
	
	#ASK GODOT:
#	var file = new()
#	file.open("res://Data/StaticData.json")
#	var text = file.get_as_text()
#	dict.parse_json(text)
#	file.close()
#	# print something from the dictionnary for testing.
#	print(dict["name"])

	
	#CHAT GPT:
	print("working")
	var json_text = preload("res://Data/allcards.json").get_parsed_text()
	var json_data = new()
	#var result = json_data.open_buffer(json_text)
	print(json_text)
#	if result == OK:
#		var json_dict = json_data.get_data()
#	else:
#		print("Failed to parse JSON")

#	DOCUMENTATION
#	var json_string = preload("res://Data/allcards.json").get_text()
#	var json = JSON.new()
#	var error = json.parse(json_string)
#	if error == OK:
#		var data_received = json.data
#		if typeof(data_received) == TYPE_ARRAY:
#			print(data_received) # Prints array
#		else:
#			print("Unexpected data")
#	else:
#		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
