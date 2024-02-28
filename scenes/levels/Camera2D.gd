extends Camera2D

#Zoom Intensity
var zoomIn = Vector2(1.1, 1.1)
var zoomOut = Vector2(0.9, 0.9)
#Camera Movement Speed
var cameraMovementSpeed = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#moveCamera()
	pass

#func _input(event):
#	if event.is_action_pressed("camera_scroll_in"):
#		zoom *= zoomIn
#	elif event.is_action_pressed("camera_scroll_out"):
#		zoom *= zoomOut
	
#	print(zoom)

func moveCamera():
	if Input.is_action_pressed("camera_up"):
		position.y -= cameraMovementSpeed
	elif Input.is_action_pressed("camera_down"):
		position.y += cameraMovementSpeed
	elif Input.is_action_pressed("camera_left"):
		position.x -= cameraMovementSpeed
	elif Input.is_action_pressed("camera_right"):
		position.x += cameraMovementSpeed
	
