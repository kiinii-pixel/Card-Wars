extends Button

signal add_card

func _pressed():
	add_card.emit()
