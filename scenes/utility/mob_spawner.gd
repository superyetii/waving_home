extends Node2D


@export var spawns: Array[Spawn_info] = []

@onready var player = get_tree().get_first_node_in_group("player")
@onready var spawnArea = get_tree().get_nodes_in_group("spawn_area")

var time = 0


func _on_timer_timeout(): #Called every second
	time += 1 #Increase a second in counter
	var mob_spawns = spawns #Take the spawn array
	for i in mob_spawns: #Iterate the array
		if time >= i.time_start and time <= i.time_end: #Check if any fits into the time range
			if i.spawn_delay_counter < i.mob_spawn_delay: #Check if delay not met
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_mob = i.mob #Prepare to spawn the enemy
				var counter = 0
				while counter < i.mob_num: #Spawn the enemy for x amount of times
					var mob_spawn = new_mob.instantiate()
					mob_spawn.global_position = get_random_position()
					add_child(mob_spawn)
					counter += 1
					
					
					
func get_random_position():
	var spawn_area = spawnArea.pick_random()
	var x_value = randf_range(-spawn_area.shape.extents.x, spawn_area.shape.extents.x)
	var y_value = randf_range(-spawn_area.shape.extents.y, spawn_area.shape.extents.y)
	
	var spawn_area_position = spawn_area.global_position
	var final_position = spawn_area_position + Vector2(x_value, y_value)
	return final_position
	
