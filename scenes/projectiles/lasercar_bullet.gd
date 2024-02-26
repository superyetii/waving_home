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
var on_move = true

@onready var particleTimer = %particleTimer
@onready var particle = %"laser particle"
@onready var laserImage = %Sprite2D

@onready var source_gun = get_tree().get_nodes_in_group("gun")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(45)
	match level:
		1:
			hp = 1
			speed = 4500
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
	
func _physics_process(delta):
	if on_move:
		position += (angle * speed * delta)
	
func mob_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		on_move = false
		laserImage.visible = false
		particle.emitting = true
		particleTimer.start()


func _on_timer_timeout():
	queue_free()


func _on_particle_timer_timeout():
	queue_free()
