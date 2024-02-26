extends Node2D

#Recoil Animation
@export var recoilanimationPlayer = AnimationMixer

#Gun rotation Spot
@export var rotation_pivot = Node2D

#Missile
var missile = preload("res://scenes/projectiles/missilecar_missile.tscn")

#Missile Initial Delay Timer
@onready var initialDelayTimer = %missileInitialDelayTimer
@export var initialDelay = 0.1

#Attack Nodes
@onready var missileTimer = %missileTimer
@onready var missileAttackTimer = %missileAttackTimer

#Missile stats
var missile_ammo = 0
var missile_baseammo = 6
var missile_attackspeed = 3
var missile_level = 1

#State of the missile
var weapon_loaded = false
var angle = Vector2(1, -1)
#Detection
@onready var detector = get_tree().get_first_node_in_group("detector")

#Mob Related
@onready var mob_close = detector.mob_close



func attack():
	if missile_level > 0:
		missileTimer.wait_time = missile_attackspeed
		if missileTimer.is_stopped():
			missileTimer.start()
			
func _ready():
	initialDelayTimer.wait_time = initialDelay
	initialDelayTimer.start()
	
func _process(delta):
	if weapon_loaded:
		#rotation_pivot.rotation = lerp(rotation_pivot.rotation, (angle.angle() + deg_to_rad(90)), 0.1)
		pass
	
	
func _on_missile_timer_timeout(): #Loading ammunition?
	missile_ammo = missile_baseammo
	missileAttackTimer.start()
	
	
func _on_missile_attack_timer_timeout(): 
	if weapon_loaded:
		if missile_ammo > 0:
			get_random_target()
			#rotation_pivot.rotation = angle.angle() + deg_to_rad(90)
			if missile_ammo > 0:
				missileAttackTimer.start()
			else:
				missileAttackTimer.stop()
	else:
		pass
		
func get_random_target():
	if mob_close.size() > 0:
		var target = -Vector2.INF
		var targetMob
		for body in mob_close:
			var mob_position = body.global_position
			if mob_position.x > target.x:
				target = mob_position
				targetMob = body
		#recoilanimationPlayer.play("basegun_recoil")
		var missile_attack = missile.instantiate()
		missile_attack.position = global_position
		missile_attack.targetMob = targetMob
		missile_attack.level = missile_level
		add_child(missile_attack)
		missile_ammo -= 1
		angle = global_position.direction_to(missile_attack.targetMob.global_position)
	else:
		pass


func _on_missile_initial_delay_timer_timeout():
	attack()
