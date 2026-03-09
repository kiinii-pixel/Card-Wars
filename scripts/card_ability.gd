class_name CardAbility extends Resource

enum Trigger { ENTER_PLAY, LEAVING_PLAY, FLOOP, TURN_START, ON_DEATH, IGNITION, CONTINUOUS }

@export var trigger: Trigger
@export var effects: Array[Effect]
