extends OptionButton

@export var deck_resource : Resource

func _ready() -> void:
	for character in deck_resource.CHARACTERS:
		add_item(character)
