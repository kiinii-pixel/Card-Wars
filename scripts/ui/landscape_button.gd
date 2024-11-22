extends OptionButton

@export var landscape_script : Script

func _ready() -> void:
	print(landscape_script.LANDSCAPES)
	for landscape in landscape_script.LANDSCAPES:
		add_item(landscape)
