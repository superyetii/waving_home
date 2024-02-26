extends Node2D

#Recoil Animation
@export var recoilanimationPlayer = AnimationMixer

#Gun rotation Spot
@export var rotation_pivot = Node2D

#Bullets
var bomb = preload("res://scenes/projectiles/bombcar_bomb.tscn")

#Bullet Initial Delay Timer
@onready var initialDelayTimer = %bombInitialDelayTimer
@export var initialDelay = 0.1

#Attack Nodes
@onready var bombTimer = %bombTimer
@onready var bombAttackTimer = %bombAttackTimer

#bomb stats
var bomb_ammo = 0
var bomb_baseammo = 1
var bomb_attackspeed = 0.6
var bomb_level = 1

#State of the gun
var weapon_loaded = false
var angle = Vector2(1, -1)
#Detection
@onready var detector = get_tree().get_first_node_in_group("detector")

#Mob Related
@onready var mob_close = detector.mob_close



func attack():
	if bomb_level > 0:
		bombTimer.wait_time = bomb_attackspeed
		if bombTimer.is_stopped():
			bombTimer.start()
			
func _ready():
	initialDelayTimer.wait_time = initialDelay
	initialDelayTimer.start()
	
func _process(delta):
	if weapon_loaded:
		rotation_pivot.rotation = lerp(rotation_pivot.rotation, (angle.angle() + deg_to_rad(90)), 0.1)
	
	
func _on_bomb_timer_timeout():
	bomb_ammo = bomb_baseammo
	bombAttackTimer.start()
	
	
func _on_bomb_attack_timer_timeout(): 
	if weapon_loaded:
		if bomb_ammo > 0:
			get_random_target()
			#rotation_pivot.rotation = angle.angle() + deg_to_rad(90)
			if bomb_ammo > 0:
				bombAttackTimer.start()
			else:
				bombAttackTimer.stop()
	else:
		pass
		
func get_random_target():
	if mob_close.size() > 0:
		var target = Vector2.INF
		for body in mob_close:
			var mob_position = body.global_position
			if mob_position.x < target.x:
				target = mob_position
		recoilanimationPlayer.play("basebomb_recoil")
		var bomb_attack = bomb.instantiate()
		bomb_attack.position = global_position
		bomb_attack.target = target
		bomb_attack.level = bomb_level
		add_child(bomb_attack)
		bomb_ammo -= 1
		angle = global_position.direction_to(bomb_attack.target)
	else:
		pass



func _on_bomb_initial_delay_timer_timeout():
	attack()
