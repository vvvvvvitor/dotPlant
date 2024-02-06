extends Turret

@onready var floor_detection: RayCast2D = $FloorDetection


func _physics_process(delta: float) -> void:
	if floor_detection.is_colliding():
		velocity.y -= jump_force * delta
	if velocity.y < -32:
		velocity.y *= 0.5

	super(delta)
