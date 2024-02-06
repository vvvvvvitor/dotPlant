extends Sprite2D


func _process(delta: float) -> void:
	flip_h = bool(clamp(get_parent().velocity.x, -1, 0))
