extends Node2D


func _process(delta: float) -> void:
	var mouse_dir = atan2(
		global_position.direction_to(get_global_mouse_position()).y,
		global_position.direction_to(get_global_mouse_position()).x
	)
	rotation = mouse_dir
	scale.y = 1 if rotation > -PI / 2 && rotation < PI / 2 else -1
