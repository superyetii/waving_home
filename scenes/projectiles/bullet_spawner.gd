extends Node2D

#Recoil Animation
@export var recoilanimationPlayer = AnimationMixer

#Gun rotation Spot
@export var rotation_pivot = Node2D

#Bullets
var bullet = preload("res://scenes/projectiles/guncar_bullet.tscn")

#Bullet Initial Delay Timer
@onready var initialDelayTimer = %bulletInitialDelayTimer
@export var initialDelay = 0.1

#Attack Nodes
@onready var bulletTimer = %bulletTimer
@onready var bulletAttackTimer = %bulletAttackTimer

#Bullet stats
var bullet_ammo = 0
var bullet_baseammo = 1
var bullet_attackspeed = 0.075
var bullet_level = 1

#State of the gun
var weapon_loaded = false
var angle = Vector2(1, -1)
#Detection
@onready var detector = get_tree().get_first_node_in_group("detector")

#Mob Related
@onready var mob_close = detector.mob_close



func attack():
	if bullet_level > 0:
		bulletTimer.wait_time = bullet_attackspeed
		if bulletTimer.is_stopped():
			bulletTimer.start()
			
func _ready():
	initialDelayTimer.wait_time = initialDelay
	initialDelayTimer.start()
	
func _process(delta):
	if weapon_loaded:
		rotation_pivot.rotation = lerp(rotation_pivot.rotation, (angle.angle() + deg_to_rad(90)), 0.1)
	
	
func _on_bullet_timer_timeout(): #Loading ammunition?
	#bullet_ammo = bullet_baseammo
	#bulletAttackTimer.start()
	if weapon_loaded:
		get_random_target()
		#bulletAttackTimer.start()
	else:
		pass
	
	
func _on_bullet_attack_timer_timeout(): 
	if weapon_loaded:
		get_random_target()
		bulletAttackTimer.start()
#		if bullet_ammo > 0:
#			get_random_target()
#			#rotation_pivot.rotation = angle.angle() + deg_to_rad(90)
#			if bullet_ammo > 0:
#				bulletAttackTimer.start()
#			else:
#				bulletAttackTimer.stop()
	else:
		pass
		
func get_random_target():
	if mob_close.size() > 0:
		var target = Vector2.INF
		for body in mob_close:
			var mob_position = body.global_position
			if mob_position.x < target.x:
				target = mob_position
		recoilanimationPlayer.play("basegun_recoil")
		var bullet_attack = bullet.instantiate()
		bullet_attack.position = global_position
		bullet_attack.target = target
		bullet_attack.level = bullet_level
		add_child(bullet_attack)
		bullet_ammo -= 1
		angle = global_position.direction_to(bullet_attack.target)
	else:
		pass


func _on_bullet_initial_delay_timer_timeout():
	attack()
