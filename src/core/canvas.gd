extends CanvasLayer


func screenshake(force: float = 1.0, shakes: int = 4, shake_duration: float = 0.02):
	var camera: Camera2D = get_viewport().get_camera_2d()
	for shake: int in shakes:
		if is_instance_valid(camera):
			camera.offset = (Vector2.ONE * randi_range(-force, force)) * (1.0 - (float(shake) if shake != 0 else 1) / float(shakes))
			await get_tree().create_timer(shake_duration, false, false, true).timeout
		else: break


func freeze(duration: float = 0.5):
	Engine.time_scale = 0
	await get_tree().create_timer(duration, false, false, true).timeout
	Engine.time_scale = 1
