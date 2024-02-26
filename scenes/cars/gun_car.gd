extends Node2D
@onready var timer = %Timer
@onready var weaponsPlayer = %weaponsAnimation
@onready var animationPlayer = %AnimationPlayer
@onready var boboanimationPlayer = %boboanimationPlayer
@onready var platformPlayer = %platformPlayer

@onready var booster_time = 5.0


@onready var covershield = %covershield_base
@onready var covershieldTimer1 = %covershieldTimer1
@onready var covershieldTimer2 = %covershieldTimer2
@onready var covershieldTimer3 = %covershieldTimer3
@onready var gatlinggunTimer = %gatlinggunTimer
@onready var unloadgatlingTimer = %unloadGatlingTimer
#Spawn point of the defaultGun bullet
@export var defaultGun = Node2D 
@onready var loadGunTimer = %loadGunTimer
#Spawn point of the gatlingGun bullet
@export var gatlingGun1 = Node2D
@export var gatlingGun2 = Node2D
@export var gatlingGun3 = Node2D
@export var gatlingGun4 = Node2D
@export var gatlingGun5 = Node2D
var gatlingGunArray = []
@onready var loadGatlingTimer = %loadGatlingTimer


@onready var gatlinggun = %gatlinggun_base
@onready var gatlingcharge1 = %charge1
@onready var gatlingcharge2 = %charge2
@onready var gatlingcharge3 = %charge3
@onready var gatlingcharge4 = %charge4
@onready var gatlingcharge5 = %charge5
@onready var gatlingchargearray = []
@onready var chargecount = 5
@onready var gatlinggunBool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#platformPlayer.play("extend")
	covershield.visible = false
	gatlinggun.visible = false
	
	gatlingGunArray.append(gatlingGun1)
	gatlingGunArray.append(gatlingGun2)
	gatlingGunArray.append(gatlingGun3)
	gatlingGunArray.append(gatlingGun4)
	gatlingGunArray.append(gatlingGun5)
	
	gatlingchargearray.append(gatlingcharge1)
	gatlingchargearray.append(gatlingcharge2)
	gatlingchargearray.append(gatlingcharge3)
	gatlingchargearray.append(gatlingcharge4)
	gatlingchargearray.append(gatlingcharge5)
	for n in range(5):
		gatlingchargearray[n].visible = false
	animationPlayer.play("run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_weapon():
	weaponsPlayer.play("load_weapon")
	boboanimationPlayer.play("load_weapon")
	loadGunTimer.start()
	
func unload_weapon():
	weaponsPlayer.play("unload_weapon")
	boboanimationPlayer.play("unload_weapon")
	defaultGun.weapon_loaded = false

func _on_initial_timer_timeout():
	load_weapon()
	
#Command_GatlingGun
func command_gatlinggun():
	gatlinggunBool = true
	unload_weapon()
	covershieldTimer1.wait_time = 0.5
	covershieldTimer1.start()
func _on_covershield1_timer_timeout():
	weaponsPlayer.play("coverup")
	covershield.visible = true
	covershieldTimer2.wait_time = 0.4
	covershieldTimer2.start()
	for n in range(5):
		gatlingchargearray[n].visible = true
func _on_covershield_timer_2_timeout():
	if gatlinggunBool:
		gatlinggun.visible = true
	else:
		gatlinggun.visible = false
	weaponsPlayer.play("coverdown")
	covershieldTimer3.wait_time = 0.2
	covershieldTimer3.start()
func _on_covershield_timer_3_timeout():
	if gatlinggunBool:
		weaponsPlayer.play("load_gatling")
		boboanimationPlayer.play("load_gatling")
		gatlinggunBool = false
		timeout_gatlinggun()
	else:
		load_weapon()
	covershield.visible = false
	
	
	

#Passive Animations
func command_booster():
	print("command_booster")
	timer.wait_time = booster_time
	animationPlayer.play("booster")
	timer.start()
func _on_timer_timeout():
	animationPlayer.play("run")





#Timeout for gatlinggun
func timeout_gatlinggun():
	chargecount = 5
	gatlinggunTimer.start()
	loadGatlingTimer.start()
func _on_gatlinggun_timer_timeout():
	if chargecount > 0:
		chargecount-=1
		gatlingchargearray[abs(chargecount)].visible = false
		if chargecount == 0:
			for i in range(5):
				gatlingGunArray[i].weapon_loaded = false
			weaponsPlayer.play("unload_gatling")
			boboanimationPlayer.play("unload_gatling")
			unloadgatlingTimer.wait_time = 0.9
			unloadgatlingTimer.start()
		else:
			gatlinggunTimer.start()
			
	else:
		print("done")
		pass
func _on_unload_gatling_timer_timeout():
	_on_covershield1_timer_timeout()

func _on_load_gun_timer_timeout():
	defaultGun.weapon_loaded = true


func _on_load_gatling_timer_timeout():
	for i in range(5):
		gatlingGunArray[i].weapon_loaded = true
