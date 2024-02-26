extends Node2D

var parallaxEffect = 500
const backgroundSize = 1920
@export var parallaxRatio:float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += parallaxEffect * parallaxRatio * delta
	if position.x > backgroundSize:
		position.x = 0
