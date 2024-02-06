extends Node


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/wave.tscn")


func _enabled():
	for attack in 2:
		var offset: float = randf_range(-PI, PI)
		for projectile in 5:
			for index in 5:
				create_projectile(((PI * 2) * (float(index) / 5.0)) + offset)
			await get_tree().create_timer(0.25, false).timeout
		await get_tree().create_timer(1.0, false).timeout


func create_projectile(direction: float):
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()

	projectile_instance.global_position = owner.global_position
	projectile_instance.direction = direction
	get_tree().current_scene.add_child.call_deferred(projectile_instance)
