extends Sprite2D
@onready var pointer = %pointer_pivot
@onready var label = %Label
var gunAngle = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	adjustCannonAngle()
	label.text = str(abs(gunAngle))
	pointer.rotation = lerp(pointer.rotation, deg_to_rad(gunAngle), 0.1)
	
func _input(event):
	if event.is_action_pressed("shoot"):
		pass
		#shoot cannon

func adjustCannonAngle():
	if Input.is_action_pressed("raise_cannon"):
		gunAngle -= 1
		gunAngle = clamp(gunAngle, -90.0, 0.0)
		#raise cannon in angles
	elif Input.is_action_pressed("lower_cannon"):
		gunAngle += 1
		gunAngle = clamp(gunAngle, -90.0, 0.0)
		#lower cannon in angles
