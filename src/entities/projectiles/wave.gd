extends Projectile2D


var time: float = 0
func _physics_process(delta: float) -> void:
	time += delta
	direction += cos(time * 2.0) * 0.02
	super(delta)
