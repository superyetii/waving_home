extends Marker2D

@export var damage_node : PackedScene

func _ready():
	randomize()

func popup(damageValue:int, crit:bool):
	var damage = damage_node.instantiate()
	damage.setLabel(damageValue, crit)
	damage.position = global_position
	var tween = get_tree().create_tween()
	tween.tween_property(damage, "position", global_position + getDirection(), 0.75)
	
	get_tree().current_scene.add_child(damage)

func getDirection():
	return Vector2(randf_range(-1, 1), -randf()) * 64
