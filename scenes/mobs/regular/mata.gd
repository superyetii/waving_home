extends CharacterBody2D

@export var movement_speed = 100.0
@export var health = 10
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO
@onready var target = get_tree().get_first_node_in_group("subtarget")
@onready var damage_popup = %damage_popup
var crit = false
@onready var blinkImage = %blink
@onready var blinkTimer = %blinkTimer


func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	
	move_and_slide()
	
	var angle = atan2(direction.y, direction.x) + PI
	rotation = angle

func blink():
	blinkImage.modulate = Color(1, 1, 1, 1)
	blinkTimer.start()

func _on_hurtbox_hurt(damage, angle, knockback_amount):
	blink()
	damage_popup.popup(damage, crit)
	health -= damage
	knockback = angle * knockback_amount
	if health <= 0:
		queue_free()
		


func _on_blink_timer_timeout():
	blinkImage.modulate = Color(1, 1, 1, 0)
