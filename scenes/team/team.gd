extends Node2D

@onready var cars = get_tree().get_nodes_in_group("train_car")
var gustav = Node2D
var pos = Vector2(280, 0)
@export var ui_interface = CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	for car in cars:
		car.position += pos
		pos.x += 260
	gustav = cars[0]
	
	ui_interface.command_fire.connect(gustav.command_fire)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#gustav.gunAngle = ui_interface.angleDisplay.gunAngle
	pass
