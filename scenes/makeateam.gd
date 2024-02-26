extends Node2D
@onready var animationPlayer = %AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	#declare entities
	var player = %player
	var locomotive = %locomotive
	var guncar = %gun_car
	
	#link base entity signals
	player.command_active.connect(locomotive.command_active)
	player.command_deactive.connect(locomotive.command_deactive)
	
	#Link booster to the team
	player.command_booster.connect(self.command_booster)
	
	#link skills to Locomotive
	player.command_booster.connect(locomotive.command_booster)
	#Link skills to Gun Car
	player.command_booster.connect(guncar.command_booster)
	player.command_gatlinggun.connect(guncar.command_gatlinggun)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func command_booster():
	animationPlayer.play("command_booster")
