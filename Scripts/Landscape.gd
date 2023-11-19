extends Node2D

func _ready():
    $ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7)

func _process(_delta):
    if Global.is_dragging: #when a card is being dragged
        $ColorRect.visible = true #highlight landscape
        if Global.is_inside: #if card overlaps landscape
            $ColorRect.modulate = Color(Color.GREEN_YELLOW, 1) #change highlight color
        else:
            $ColorRect.modulate = Color(Color.MEDIUM_SEA_GREEN, 0.7) #change back
    else:
        $ColorRect.visible = false #remove highlight
