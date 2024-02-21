extends Resource
class_name Deck

@export_enum("Finn", "Jake", "BMO", "Lady Rainicorn", "Princess Bubblegum",
"Lumpy Space Princess", "Ice King", "Marceline", "Lemongrab", "Gunter",
"Fionna", "Cake") var character : int
#var character : String // if i need the actual name instead of ID

#@export var deck = [
#7, 501, 505, 460, 499, 81, 114, 124, 215, 340, 344, 437, 480,
#496, 498, 452, 33, 65, 384, 497, 190, 67
#]
@export var deck = []


@export_group("Landscapes")
enum landscapes {BLUE_PLAINS, CORN, NICE_LANDS}
@export var landscape1: landscapes
@export var landscape2: landscapes
@export var landscape3: landscapes
@export var landscape4: landscapes
