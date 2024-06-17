extends Control

@onready var resolutions_button = $Options/VBoxContainer/OptionButton

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

var resolutions = {
	"1920x1080" : Vector2i(1920, 1080),
	"1366x768" : Vector2i(1366, 768)
}

func _ready():
	add_resolutions()

func add_resolutions():
	for r in resolutions:
		resolutions_button.add_item(r)
