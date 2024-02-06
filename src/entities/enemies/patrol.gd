extends Node

@export var destination: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	owner.velocity.x += sign(owner.global_position.direction_to(destination).x) * owner.walk_speed * delta
	if owner.is_on_wall():
		if owner.is_on_floor():
			owner.velocity.y -= owner.jump_force
