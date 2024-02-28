extends Area2D

#Base values, ignore
var level = 1
var hp = 1
var speed = 0
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var velocity = Vector2(0, 0)

var target = Vector2.ZERO
var angle = Vector2.ZERO

const shell_gravity = 800

@onready var source_gun = get_tree().get_nodes_in_group("gun")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(45)
	match level:
		1:
			hp = 1
			damage = 50
			knockback_amount = 100
			attack_size = 1.0
			
func _physics_process(delta):
	#position += (angle * speed * delta)
	var horizontal_motion = velocity.x * delta
	position.x += horizontal_motion
	
	velocity.y += shell_gravity * delta
	var vertical_motion = velocity.y * delta
	position.y += vertical_motion
	
	rotation = velocity.angle() + deg_to_rad(45)
	
func mob_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_timer_timeout():
	queue_free()
