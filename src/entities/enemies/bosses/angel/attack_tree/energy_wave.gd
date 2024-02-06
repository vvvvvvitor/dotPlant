extends Node


const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/energy_ball.tscn")


@onready var boss_animation: AnimationPlayer = $"../../../BossAnimation"

func _enabled():
	var player_position = Core.get_player().global_position
	var space_state = owner.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		player_position,
		player_position + Vector2(0, -128),
		1
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	var result = space_state.intersect_ray(query)

	var teleport_position = player_position - Vector2(0, 96)
	if result:
		teleport_position = result.position + Vector2(0, 16)
	boss_animation.play("Teleport")
	await get_tree().create_timer(0.25).timeout
	owner.global_position = teleport_position if teleport_position.x > 40 else Vector2(512, -64)

	for attack in 32:
		if get_parent().process_mode == PROCESS_MODE_DISABLED:
			break
		create_projectile(attack)

		if !is_inside_tree():
			break

		await get_tree().create_timer(0.25, false).timeout
	if get_parent().name == "Phase2":
		get_parent().set_behaviour("LaserFlower")
		return
	await get_tree().create_timer(2.0, false).timeout
	get_parent().set_behaviour("LaserPeek")


func create_projectile(direction: float):
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()

	projectile_instance.global_position = owner.global_position
	projectile_instance.direction = direction
	if get_tree():
		if get_tree().current_scene:
			get_tree().current_scene.add_child.call_deferred(projectile_instance)
