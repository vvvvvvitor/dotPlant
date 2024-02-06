extends Boss


signal wings_destroyed
@export var wings: Array[WorldEntity2D]


func _ready() -> void:
	for wing in wings:
		wing.status_state_changed.connect(delete_wing.bind(wing))


func delete_wing(_so, _sn, wing):
	wings.erase(wing)
	if wings.is_empty():
		wings_destroyed.emit()
		get_hitbox().set_deferred("monitorable", true)
		get_hitbox().set_deferred("monitoring", true)


func _physics_process(delta: float) -> void:
	rotation += velocity.x * 0.01 * delta
	if physics_state == PHYSICS_STATES.IDLE:
		var col: KinematicCollision2D = get_last_slide_collision()
		if col:
			up_direction = lerp(up_direction, col.get_normal(), 0.1)

	do_physics(delta)
	move_and_slide()
