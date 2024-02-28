extends Node2D

@onready var cars = get_tree().get_nodes_in_group("train_car")
var pos = Vector2(280, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	for car in cars:
		car.position += pos
		pos.x += 260


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
