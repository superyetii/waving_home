extends Node2D
@onready var animationPlayer = get_node("AnimationPlayer")
@onready var eyes_animation = get_node("Eyes Animation")
@onready var platformPlayer = %platformPlayer
@onready var onwatch = false #refers to the state of the eyes of the locomotive
@onready var timer = %Timer

var health = 200

signal readytolisten


#Skill-related variables
#Booster
@onready var booster_time = 5.0
#Some other skill


# Called when the node enters the scene tree for the first time.
func _ready():
	platformPlayer.play("extend")
	animationPlayer.play("run")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass
		
	
func command_active():
	if(onwatch):
		pass
	else:
		onwatch = true
		eyes_animation.play("command_active")
func command_deactive():
	onwatch = false
	eyes_animation.play("command_deactive")


func _on_eyes_animation_animation_finished(anim_name):
	if(anim_name == "command_deactive"):
		emit_signal("readytolisten")
		eyes_animation.play("command_rest")
		
		
# Locomotive Skills
func command_booster():
	print("command_booster")
	timer.wait_time = booster_time
	animationPlayer.play("booster")
	timer.start()


func _on_timer_timeout():
	animationPlayer.play("run")


func _on_hurtbox_hurt(damage, angle, knockback):
	health -= damage
	print(health)
