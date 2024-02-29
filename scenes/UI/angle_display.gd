extends Sprite2D
@onready var pointer = %pointer_pivot
@onready var label = %Label
@onready var sound = %sound_effect
@onready var soundTimer = %sound
var on_move = false
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
		if on_move == false and gunAngle != -90:
			startSound()
			on_move = true
		else:
			pass
		gunAngle -= 1
		gunAngle = clamp(gunAngle, -90.0, 0.0)
		#raise cannon in angles
	elif Input.is_action_pressed("lower_cannon"):
		if on_move == false and gunAngle != 0:
			startSound()
			on_move = true
		else:
			pass
		on_move = true
		gunAngle += 1
		gunAngle = clamp(gunAngle, -90.0, 0.0)
		#lower cannon in angles
	else:
		if on_move == false:
			pass
		else:
			stopSound()
			on_move = false

func stopSound():
	soundTimer.stop()
func startSound():
	if gunAngle != 0 and gunAngle != -90:
		sound.play()
	soundTimer.start()

func _on_sound_timeout():
	if gunAngle != 0 and gunAngle != -90:
		sound.play()
