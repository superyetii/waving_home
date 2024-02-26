extends Area2D

var mob_close = [] 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if not mob_close.has(body):
		mob_close.append(body)
	

func _on_body_exited(body):
	if mob_close.has(body):
		mob_close.erase(body)
