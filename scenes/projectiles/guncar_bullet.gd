extends Area2D
@onready var soundEffect = %sound_effect

#Base values, ignore
var level = 1
var hp = 1
var speed = 200
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var source_gun = get_tree().get_nodes_in_group("gun")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(45)
	match level:
		1:
			hp = 3
			speed = 2000
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
	
func _physics_process(delta):
	position += (angle * speed * delta)
	
func mob_hit(charge = 1):
	hp -= charge
	#soundEffect.play()
	if hp <= 0:
		queue_free()


func _on_timer_timeout():
	queue_free()
