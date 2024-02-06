extends GPUParticles2D
class_name OneShotGPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	await get_tree().create_timer(lifetime + 4.0, false, false, false).timeout
	queue_free()
