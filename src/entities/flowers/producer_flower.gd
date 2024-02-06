extends Flower


func _action(_target: Node, _target_area: TargetArea2D) -> void:
	var projectile_instance = projectile.instantiate()
	projectile_instance.global_position = global_position + Vector2(0, -32)
	var up_angle = up_direction.angle()
	projectile_instance.direction = randf_range(up_angle - 0.2, up_angle + 0.2)
	get_tree().current_scene.add_child(projectile_instance)
