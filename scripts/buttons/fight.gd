extends Button

signal fight

func _pressed():
	fight.emit()
