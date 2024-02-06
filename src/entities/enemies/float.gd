extends Node


var time: float = 0
func _physics_process(delta: float) -> void:
	time += delta
	var desired_position = owner.get_parent().global_position + Vector2(cos(time) * 96,sin(time) * 16.0)

	owner.velocity += owner.global_position.direction_to(desired_position) * owner.walk_speed * delta
