extends LaserProjectile2D

@export var move_amount: float = 0.5


func _physics_process(delta: float) -> void:
	super(delta)
	direction += move_amount * delta

