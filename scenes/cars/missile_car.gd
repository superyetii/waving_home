extends Node2D
@export var defaultMissile1 = Node2D
@export var defaultMissile2 = Node2D
@onready var motionPlayer = %motionPlayer
@onready var weaponsPlayer = %weaponsPlayer
@onready var boboanimationPlayer = %boboanimationPlayer
@onready var loadMissileTimer = %loadMissileTimer
@onready var platformPlayer = %platformPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#platformPlayer.play("extend")
	motionPlayer.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func load_weapon():
	weaponsPlayer.play("load_weapon")
	boboanimationPlayer.play("load_weapon")
	loadMissileTimer.start()
	
func unload_weapon():
	weaponsPlayer.play("unload_weapon")
	boboanimationPlayer.play("unload_weapon")
	defaultMissile1.weapon_loaded = false
	defaultMissile2.weapon_loaded = false

func _on_load_missile_timer_timeout():
	defaultMissile1.weapon_loaded = true
	defaultMissile2.weapon_loaded = true


func _on_initial_timer_timeout():
	load_weapon()
