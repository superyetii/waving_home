extends Sprite2D
@onready var powerBar = %powerBar
@onready var prevBar = %prevPower
const max = 100
const min = 0
var reset = false

signal fire(power)

# Called when the node enters the scene tree for the first time.
func _ready():
	powerBar.value = 0.0
	prevBar.value = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movePowerBar()
	checkForFire()
	if reset:
		powerBar.value = lerp(powerBar.value, .0, 0.1)
	if powerBar.value <= .5:
		reset = false
func movePowerBar():
	if Input.is_action_pressed("shoot"):
		reset = false
		powerBar.value += .5

func checkForFire():
	if Input.is_action_just_released("shoot"):
		emit_signal("fire", powerBar.value)
		prevBar.value = powerBar.value
		reset = true
