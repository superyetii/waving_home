extends Area2D

#Time before the missile turns homing
@onready var cookTimer = %cookTimer
var isCooking = true

#Base values, ignore
var level = 1
var hp = 1
var speed = 200
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var targetMob
var angle = Vector2.ZERO

#Detection
@onready var detector = get_tree().get_first_node_in_group("detector")
@onready var mob_close = detector.mob_close

#Things to add: straight before homing

func _ready():
	angle = global_position.direction_to(targetMob.global_position)
	rotation = angle.angle() + deg_to_rad(45)
	match level:
		1:
			hp = 1
			speed = 1000
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
	
func _physics_process(delta):
	if isCooking:
		cookMissile(delta)
	else: 
		chaseTarget(delta)

func chaseTarget(delta):
	if targetMob and is_instance_valid(targetMob):
		#angle = global_position.direction_to(targetMob.global_position)
		look_at(targetMob.global_position)
		position = position.move_toward(targetMob.global_position, speed * delta)
	else:
		if acquireTarget():
			#angle = global_position.direction_to(targetMob.global_position)
			look_at(targetMob.global_position)
			position = position.move_toward(targetMob.global_position, speed * delta)
		else:
			#angle = Vector2.RIGHT
			#rotation = angle.angle()
			position+= speed * Vector2.RIGHT.rotated(rotation) * delta
	#position += (angle * speed * delta)
	
	
func cookMissile(delta):
	angle = Vector2.UP
	rotation = angle.angle()
	position += (angle * speed * delta)	

func acquireTarget():
	if mob_close.size() > 0:
		targetMob = mob_close.pick_random()
		return true
	else:
		return false

	
func mob_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_timer_timeout():
	queue_free()


func _on_cook_timer_timeout():
	isCooking = false
