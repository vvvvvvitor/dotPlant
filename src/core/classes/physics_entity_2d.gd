extends Entity2D
class_name PhysicsEntity2D

signal physics_state_changed(old:PHYSICS_STATES, new:PHYSICS_STATES)
signal collided(col: KinematicCollision2D)


enum PHYSICS_STATES {
	IDLE,
	MOVING,
	FALLING,
	LANDED
}


@export_category("Physics")
@export_range(0.0, 1.0) var ground_friction:float = 0.8
@export_range(0.0, 1.0) var air_friction:float = 1.0

@export var gravity: int = 480
@export var idle_threshold: float = 1.0


var physics_state: PHYSICS_STATES = PHYSICS_STATES.IDLE:
	set(val):
		physics_state_changed.emit(physics_state, val)
		physics_state = val


func _physics_process(delta):
	do_physics(delta)
	move_and_slide()


func do_physics(delta: float = 1.0) -> void:
	if get_slide_collision_count() != 0:
		collided.emit(get_last_slide_collision())

	match motion_mode:
		MOTION_MODE_FLOATING:
			match physics_state:
				PHYSICS_STATES.IDLE:
					if velocity.length() != 0:
						physics_state = PHYSICS_STATES.MOVING
				PHYSICS_STATES.MOVING:
					velocity *= ground_friction
					if velocity.length() < idle_threshold:
						physics_state = PHYSICS_STATES.IDLE
						velocity = Vector2.ZERO
		MOTION_MODE_GROUNDED:
			match physics_state:
				PHYSICS_STATES.IDLE:
					velocity.x *= ground_friction

					if !is_on_floor():
						physics_state = PHYSICS_STATES.FALLING
				PHYSICS_STATES.FALLING:
					velocity.x *= ground_friction * air_friction
					velocity.y *= air_friction
					velocity -= up_direction * gravity * delta

					if is_on_floor():
						physics_state = PHYSICS_STATES.LANDED
				PHYSICS_STATES.LANDED:
					velocity.y = 0
					physics_state = PHYSICS_STATES.IDLE


func get_collision_shape() -> CollisionShape2D:
	for node in get_children():
		if node is CollisionShape2D:
			return node
	return
