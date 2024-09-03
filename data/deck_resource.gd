class_name DeckResource extends Resource

@export_enum("Finn", "Jake", "BMO", "Lady Rainicorn", "Princess Bubblegum",
"Lumpy Space Princess", "Ice King", "Marceline", "Lemongrab", "Gunter",
"Fionna", "Cake") var character : int
#var character : String // if i need the actual name instead of ID

@export var deck : Array[CardResource]
#@export var cards : Array[CardResource] should call this cards for clarity

@export_group("Landscapes")
enum landscapes {BLUE_PLAINS, CORN, NICE_LANDS}
@export var landscape1 : landscapes
@export var landscape2 : landscapes
@export var landscape3 : landscapes
@export var landscape4 : landscapes
