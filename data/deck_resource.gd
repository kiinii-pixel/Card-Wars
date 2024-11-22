class_name DeckResource extends Resource

enum CHARACTERS {Finn, Jake, BMO, Lady_Rainicorn, PrincessBubblegum,
 LumpySpacePrincess, IceKing, Marceline, Lemongrab, Gunter, Fionna, Cake}
@export var character : CHARACTERS

@export var deck : Array[CardResource]
#@export var cards : Array[CardResource] should call this cards for clarity

@export_group("Landscapes")
enum landscapes {Blue_Plains, Corn, NiceLands, Rainbow, Sandy_Lands, Useless_Swamp}
@export var landscape1 : landscapes
@export var landscape2 : landscapes
@export var landscape3 : landscapes
@export var landscape4 : landscapes
