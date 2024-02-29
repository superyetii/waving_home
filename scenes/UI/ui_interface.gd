extends CanvasLayer

@onready var angleDisplay = %angle_display
signal command_fire(angle, power)
@onready var waveTimer = %"Wave Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	waveTimer.position.x = (DisplayServer.window_get_size().x / 2) - waveTimer.size.x / 2


func _on_power_gauge_fire(power):
	var fireAngle = angleDisplay.gunAngle
	var firePower = power
	emit_signal("command_fire", fireAngle, firePower)

