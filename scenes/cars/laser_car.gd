extends Node2D
@export var defaultLaser = Node2D
@onready var motionPlayer = %motionPlayer
@onready var weaponsPlayer = %weaponsPlayer
@onready var boboanimationPlayer = %boboanimationPlayer
@onready var loadLaserTimer = %loadLaserTimer
@onready var platformPlayer = %platformPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	platformPlayer.play("extend")
	motionPlayer.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func load_weapon():
	weaponsPlayer.play("load_weapon")
	boboanimationPlayer.play("load_weapon")
	loadLaserTimer.start()
	
func unload_weapon():
	weaponsPlayer.play("unload_weapon")
	boboanimationPlayer.play("unload_weapon")
	defaultLaser.weapon_loaded = false

func _on_load_laser_timer_timeout():
	defaultLaser.weapon_loaded = true


func _on_initial_timer_timeout():
	load_weapon()
