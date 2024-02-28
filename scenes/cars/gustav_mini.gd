extends Node2D

@onready var cannon = %rotation_pivot
@onready var eye = %eye
var gunAngle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cannon.rotation = lerp(cannon.rotation, deg_to_rad(gunAngle), 0.1)
	eye.rotation = lerp(cannon.rotation, deg_to_rad(gunAngle), 0.1)
	


	
