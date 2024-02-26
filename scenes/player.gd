extends Node2D
@onready var animationPlayer = get_node("newPlayer")
@onready var characterbody = %player_movement
const MAX_INPUTS = 4
@onready var cmdGatlingTimer = %cmdGatlingTimer
@onready var commandTimer = %commandTimer
@onready var attackTimer = %attackTimer

#input signals
signal command_active
signal command_deactive

#ability signals
signal command_booster
signal command_gatlinggun

#input combinations
var current_input = [] #storage for current input
var input_combinations = [ #possible combinations of inputs
	["right", "left", "up", "up"], #command_gatlinggun
	["left", "left", "up", "right"], #command_booster
]

#Skill animation counter
var gatlinggun_anim = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#Input processing
func _input(event):
	if event.is_action_pressed("command_up"):
		commandTimer.start()
		add_input("up")
	elif event.is_action_pressed("command_down"):
		commandTimer.start()
		add_input("down")
	elif event.is_action_pressed("command_left"):
		commandTimer.start()
		add_input("left")
	elif event.is_action_pressed("command_right"):
		commandTimer.start()
		add_input("right")
	elif event.is_action_pressed("command_trigger") and characterbody.is_on_floor():
		characterbody.on_command = true
		command_trigger()
		animationPlayer.play("attack")
		attackTimer.start()
		#trigger the command


#Add input
func add_input(new_input):
	#add new input into array
	current_input.append(new_input)
	while current_input.size() > MAX_INPUTS:
		current_input.remove_at(0)



#Base Commands
func command_up():
	pass
	
func command_down():
	pass
	
func command_left():
	pass
	
func command_right():
	pass
	
#Read and Trigger Command
func command_trigger():
	if(current_input == input_combinations[0]):
		gatlinggun()
	elif(current_input == input_combinations[1]):
		emit_signal("command_booster")


func gatlinggun():
	match gatlinggun_anim:
		4:
			characterbody.on_command = true
			emit_signal("command_active")
			#command_right()
			cmdGatlingTimer.start()
		3:
			#command_left()
			cmdGatlingTimer.start()
		2:
			#command_up()
			cmdGatlingTimer.start()
		1:
			#command_up()
			cmdGatlingTimer.start()
		0:
			emit_signal("command_gatlinggun")
			gatlinggun_anim = 4
			characterbody.on_command = false
			emit_signal("command_deactive")
			

func _on_cmd_gatling_timer_timeout():
	#animationPlayer.play("command_rest")
	gatlinggun_anim -= 1
	gatlinggun()


func _on_command_timer_timeout():
	current_input.clear()


func _on_attack_timer_timeout():
	print("cheese")
	characterbody.on_command = false
