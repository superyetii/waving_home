extends Area2D





func _on_body_entered(body):
	body.target = get_tree().get_first_node_in_group("target")
