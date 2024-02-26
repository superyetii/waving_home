extends Area2D

#Base values, ignore
var level = 1
var hp = 1
var speed = 200
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

#Make the bomb spin
@onready var animationPlayer = %AnimationPlayer

@onready var source_gun = get_tree().get_nodes_in_group("gun")

func _ready():
	animationPlayer.play("spin")
	angle = global_position.direction_to(target)
	match level:
		1:
			hp = 1
			speed = 500
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
	
func _physics_process(delta):
	position += (angle * speed * delta)
	
func mob_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_timer_timeout():
	queue_free()
