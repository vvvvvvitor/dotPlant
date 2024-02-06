extends Node


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/holy_laser.tscn")


func _enabled():
	for attack in 6:
		if get_parent().process_mode == PROCESS_MODE_DISABLED:
			break
		create_projectile(lerp(-PI, PI, float(attack) / 4.0))
		await get_tree().create_timer(1.0, false).timeout
	get_parent().set_behaviour("EnergyWave")


func create_projectile(direction: float):
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()

	#projectile_instance.global_position = owner.global_position
	projectile_instance.direction = direction
	owner.add_child.call_deferred(projectile_instance)
