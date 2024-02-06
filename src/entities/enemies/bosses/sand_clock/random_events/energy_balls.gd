extends Node


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/energy_ball.tscn")


func _enabled():
	for attack in 3:
		var offset: float = randf_range(-PI, PI)
		for index in 5:
			create_projectile(((PI * 2) * (float(index) / 5.0)) + offset)
		await get_tree().create_timer(2.5, false).timeout


func create_projectile(direction: float):
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()

	projectile_instance.global_position = owner.global_position
	projectile_instance.direction = direction
	get_tree().current_scene.add_child.call_deferred(projectile_instance)
