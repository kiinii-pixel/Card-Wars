class_name DamageEffect extends Effect

@export var damage: int = 2

func execute(card: Card):
	print(card.name + " damaged something")
