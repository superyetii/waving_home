extends Resource

class_name Spawn_info

@export var time_start:int # When to start spawning
@export var time_end:int # When to end spawning
@export var mob:Resource # What to spawn
@export var mob_num:int # How many to spawn
@export var mob_spawn_delay:int # Seconds of delay between spawns
#Note! The base is a spawn every second. 
#The delay is added on top of this, so a second of mob_spawn_delay will result in 2 seconds interval between spawns
var spawn_delay_counter = 0 # Tracks the delayed seconds in between spawns
