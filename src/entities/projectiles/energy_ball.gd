extends Projectile2D

const EXPLOSION: PackedScene = preload("res://res/scenes/nodes/explosions/energy_ball_explosion.tscn")



func __on_status_state_change(old: int, new: int):
	var explosion_instance = EXPLOSION.instantiate()
	explosion_instance.global_position = global_position
	get_tree().current_scene.add_child.call_deferred(explosion_instance)
	super(old, new)
