extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -600.0
@onready var parallaxBackground = get_tree().get_first_node_in_group("parallax")
@onready var camera2D = %Camera2D
@export var bobo = Node2D
@export var on_command = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2000

@onready var animationPlayer = %newPlayer
@onready var bodybone = %bodybone

func _physics_process(delta):
	parallaxBackground.position.x = camera2D.position.x
	if not on_command:
		# Add the gravity.
		if not is_on_floor():
			animationPlayer.play("jump")
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY			

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if is_on_floor():
				animationPlayer.play("run")
			if direction > 0:
				bodybone.scale.x = 1
			else:
				bodybone.scale.x = -1
			bobo.position = bobo.position.move_toward(Vector2(-100, -40), 100 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor():
				animationPlayer.play("idle")
				bobo.position = bobo.position.move_toward(Vector2(-77, -40), 100 * delta)
			

		move_and_slide()
