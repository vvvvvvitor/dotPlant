extends CPUParticles2D
class_name OneShotCPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	finished.connect(queue_free)
