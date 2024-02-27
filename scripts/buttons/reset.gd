extends Button

signal reset

func _pressed():
	reset.emit()
