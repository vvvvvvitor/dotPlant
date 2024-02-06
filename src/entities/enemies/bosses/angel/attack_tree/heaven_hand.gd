extends Node2D

const PROJECTILE = preload("res://res/scenes/nodes/entities/projectiles/heaven_hand.tscn")
const CROSSHAIR = preload("res://res/textures/ui/crosshair.png")


func _enabled():
	hide()
	await get_tree().create_timer(1.0).timeout
	show()
	for attack in 4:
		var projectile_instance: Projectile2D = PROJECTILE.instantiate()
		projectile_instance.global_position = Core.get_player().global_position
		queue_redraw()
		await get_tree().create_timer(0.5, false).timeout
		get_tree().current_scene.add_child.call_deferred(projectile_instance)
		await get_tree().create_timer(pow(1.0 - float(attack) / 16.0, 4.0), false).timeout
	get_parent().set_behaviour("LaserPeek")
	hide()


func _physics_process(delta: float) -> void:
	owner.velocity.x += owner.global_position.direction_to(Core.get_player().global_position).x * owner.walk_speed * delta


func _draw() -> void:
	var inv = get_global_transform().inverse()
	draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())

	draw_texture(CROSSHAIR, Core.get_player().global_position - Vector2(8, 16))
