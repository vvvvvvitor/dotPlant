extends WorldEntity2D
class_name Boss

const ENERGY: PackedScene = preload("res://res/scenes/nodes/entities/energy.tscn")
const EXPLOSION: PackedScene = preload("res://res/scenes/nodes/particles/explosion_particles.tscn")
const FINAL_BLOW = preload("res://res/sounds/final_blow.ogg")


func _init() -> void:
	free_after_death = false
	await ready
	Core.boss_spawned.emit(name)


func _damaged(damage: int, who: DamageBox2D) -> void:
	if randi_range(0, 100) < 20:
		var energy_instance = ENERGY.instantiate()
		energy_instance.global_position = who.global_position
		get_tree().current_scene.add_child.call_deferred(energy_instance)
	super(damage, who)


func __on_status_state_change(old: int, new: int):
	super(old, new)
	var sprite_rect = get_sprite().get_rect()
	Canvas.freeze(0.5)
	Canvas.screenshake(16, 16)
	if new == Entity2D.DEAD:
		Audio.add_sound(AudioBuilder.create(FINAL_BLOW, 4))
		for _i in range(70):
			var energy_instance = ENERGY.instantiate()
			var random_position = Vector2(
				randi_range(-sprite_rect.size.x / 2, sprite_rect.size.x / 2),
				randi_range(-sprite_rect.size.y / 2, sprite_rect.size.y / 2)
			)
			energy_instance.global_position = global_position + random_position
			get_tree().current_scene.add_child.call_deferred(energy_instance)
			await get_tree().create_timer(0.1, false).timeout
		var explosion_instance = EXPLOSION.instantiate()
		explosion_instance.global_position = global_position
		get_tree().current_scene.add_child(explosion_instance)
		await get_tree().create_timer(1.5, false).timeout
		Projectile2D.clear_projectiles()
		Core.boss_defeated.emit(name)
		queue_free()

	#await get_tree().create_timer()
