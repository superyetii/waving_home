extends Node2D

#Laser target Raycast2D
@onready var raycast2D = %RayCast2D
#Charge animation
@export var chargeAnimationPlayer = AnimationMixer
#Gun rotation Spot
@export var rotation_pivot = Node2D
#Detection
@onready var detector = get_tree().get_first_node_in_group("detector")
#Mob Related
@onready var mob_close = detector.mob_close
var targetMob
#State of the laser
var weapon_loaded = false
var angle = Vector2(1, -1)
var releasing = false
#Laser Stats
var laser_ammo = 0
var laser_baseammo = 1
var laser_attackspeed = 3
var laser_level = 1
#Laser Initial Delay Timer
@onready var initialDelayTimer = %laserInitialDelayTimer
@export var initialDelay = 0.1
@onready var laserTimer = %laserTimer
@onready var laserAttackTimer = %laserAttackTimer
@onready var laserChargeTimer = %laserChargeTimer
var target = Vector2.INF

#LaserBullet Ammo
var laserbullet = preload("res://scenes/projectiles/lasercar_bullet.tscn")

func attack():
	laserTimer.wait_time = laser_attackspeed
	if laserTimer.is_stopped():
		laserTimer.start()
		
func _ready():
	initialDelayTimer.wait_time = initialDelay
	initialDelayTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if weapon_loaded:
		rotation_pivot.rotation = lerp(rotation_pivot.rotation, (angle.angle() + deg_to_rad(90)), 0.1)
	if mob_close.size() > 0:
		target = Vector2.INF
		for body in mob_close:
			var mob_position = body.global_position
			if global_position.distance_to(mob_position) < global_position.distance_to(target):
				target = mob_position
				targetMob = body
		angle = global_position.direction_to(target)
	else:
		pass
func _on_laser_timer_timeout():
	laser_ammo = laser_baseammo
	laserAttackTimer.start()

func _on_laser_attack_timer_timeout():
	if weapon_loaded:
		if laser_ammo > 0:
			get_random_target()
			if laser_ammo > 0:
				laserAttackTimer.start()
			else:
				laserAttackTimer.stop()
	else:
		pass

func get_random_target():
	if mob_close.size() > 0:
		laser_ammo -= 1
		chargeAnimationPlayer.play("laser_charge")
		releasing = true
		laserChargeTimer.start()
	else:
		pass


func _on_laser_initial_delay_timer_timeout():
	attack()


func _on_laser_charge_timer_timeout():
	var laser_attack = laserbullet.instantiate()
	laser_attack.position = global_position
	laser_attack.target = target
	laser_attack.level = laser_level
	add_child(laser_attack)
