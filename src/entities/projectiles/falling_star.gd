extends Projectile2D


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/small_falling_star.tscn")


func __on_status_state_change(old: int, new: int):
	for index in randi_range(3, 5):
		var projectile_instance = PROJECTILE.instantiate()
		projectile_instance.direction = randf_range(-(PI / 2) - 0.5, -(PI / 2) + 0.5)
		projectile_instance.global_position = global_position
		get_tree().current_scene.add_child.call_deferred(projectile_instance)
	super(old, new)
