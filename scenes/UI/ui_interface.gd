extends CanvasLayer

@onready var angleDisplay = %angle_display
signal command_fire(angle, power)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_power_gauge_fire(power):
	var fireAngle = angleDisplay.gunAngle
	var firePower = power
	emit_signal("command_fire", fireAngle, firePower)
