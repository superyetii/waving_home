extends Node2D

@onready var cannon = %rotation_pivot
@onready var shell_spawner = %shell_spawner
@onready var eye = %eye
@onready var fireTimer = %fireTimer
@onready var coolTimer = %coolTimer
@onready var animationPlayer = %animation
@onready var runAnimation = %mainPlayer
var gunAngle = 0.0
var gunPower = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	runAnimation.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cannon.rotation = lerp(cannon.rotation, deg_to_rad(gunAngle), 0.1)
	eye.rotation = lerp(cannon.rotation, deg_to_rad(gunAngle), 0.1)
	
func command_fire(angle, power):
	gunAngle = angle
	gunPower = power
	shell_spawner.shoot(gunAngle, gunPower)
	animationPlayer.play("recoil")
	#fireTimer.start()
	print(angle)
	print(power)
	
func _on_fire_timer_timeout(): #Shoot
	#shell_spawner.shoot(gunAngle, gunPower)
	coolTimer.start()


func _on_cool_timer_timeout(): #Reset the gun
	gunAngle = 0
	gunPower = 0
