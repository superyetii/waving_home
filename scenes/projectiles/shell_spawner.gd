extends Node2D
var shell = preload("res://scenes/projectiles/cannon_shell.tscn")
var shell_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(angle, power):
	var shell_attack = shell.instantiate()
	shell_attack.position = global_position
	shell_attack.level = shell_level
	shell_attack.velocity = Vector2(500+(power * 30), 0).rotated(deg_to_rad(angle))
	add_child(shell_attack)
