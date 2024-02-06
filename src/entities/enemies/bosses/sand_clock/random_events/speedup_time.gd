extends Node


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/missile.tscn")


func _enabled():
	for index in 5:
		var direction_vector = owner.global_position.direction_to(Core.get_player().global_position)

		create_projectile(atan2(direction_vector.y, direction_vector.x))
		await get_tree().create_timer(0.5, false).timeout


func create_projectile(direction: float):
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()

	projectile_instance.global_position = owner.global_position
	projectile_instance.direction = direction
	get_tree().current_scene.add_child.call_deferred(projectile_instance)
