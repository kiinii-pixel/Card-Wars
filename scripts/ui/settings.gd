extends Control

@onready var resolutions_button = $Options/VBoxContainer/ResolutionOptionButton

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


func _on_resolution_option_button_item_selected(index):
	var key = resolutions_button.get_item_text(index)
	get_window().set_size(resolutions[key])
	center_window()

func center_window():
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)
