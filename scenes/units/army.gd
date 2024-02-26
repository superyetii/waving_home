extends Node2D

@onready var gunners = get_tree().get_nodes_in_group("gunner")
var pos = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	for ball in gunners:
		print(ball.name)
		ball.position += pos
		print(pos.x)
		pos.x -= 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
