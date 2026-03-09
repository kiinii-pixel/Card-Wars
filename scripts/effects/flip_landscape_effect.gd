class_name FlipLandscapeEffect extends Effect

# True: Flip up / False: Flip down
@export var up : bool

func execute(card: Card):
	var opposing_landscape: Landscape = card.get_opposing_landscape()
	opposing_landscape.flip_down()
	print("flip")
