extends Projectile2D



func _physics_process(delta: float) -> void:
	var vector_direction = global_position.direction_to(Core.get_player().global_position)
	direction = atan2(vector_direction.y, vector_direction.x)
	super(delta)
