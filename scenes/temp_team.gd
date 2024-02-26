extends Node2D
@onready var animationPlayer = %AnimationPlayer
@export var gunCar = []
# Called when the node enters the scene tree for the first time.
func _ready():
	#declare entities
	var player = %player
	var locomotive = %locomotive
	
	#link base entity signals
	#player.command_active.connect(locomotive.command_active)
	#player.command_deactive.connect(locomotive.command_deactive)
	
	#Link booster to the team
	#player.command_booster.connect(self.command_booster)
	
	#link skills to Locomotive
	#player.command_booster.connect(locomotive.command_booster)
	#Link skills to Gun Car
	#for x in range(3):
	#	player.command_booster.connect(get_node(gunCar[x]).command_booster)
	#	player.command_gatlinggun.connect(get_node(gunCar[x]).command_gatlinggun)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func command_booster():
	animationPlayer.play("command_booster")
