extends Marker2D

@onready var label = %Label
var damageText
var crit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(damageText)
	if crit:
		label.modulate = Color(1, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setLabel(text_string, crit_bool):
	damageText = text_string
	crit = crit_bool
	
