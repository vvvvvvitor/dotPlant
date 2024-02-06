extends Node2D

const PROJECTILE = preload("res://res/scenes/nodes/entities/projectiles/holy_laser.tscn")


func _process(delta: float) -> void:
	queue_redraw()


var offset: PackedFloat32Array = [randf_range(0.0, PI*2), randf_range(0.0, PI*2)]
func _enabled():
	show()
	offset = [randf_range(0.0, PI*2), randf_range(0.0, PI*2)]
	await get_tree().create_timer(1.0, false).timeout
	for attack in 2:
		randomize()
		for beams in 8:
			var projectile_instance = PROJECTILE.instantiate()
			projectile_instance.direction = offset[attack] + lerp(0.0, PI * 2, float(beams) / 8.0)
			owner.add_child.call_deferred(projectile_instance)
		await get_tree().create_timer(1.0, false).timeout
	get_parent().set_behaviour("HeavenHand")
	hide()



func _draw() -> void:
	var inv = get_global_transform().inverse()
	draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())

	for attack in 2:
		for beams in 8:
			var angle = (offset[attack] + lerp(0.0, PI * 2, float(beams) / 8.0))
			var direction = Vector2(cos(angle), sin(angle))
			draw_line(
				owner.global_position,
				global_position + direction * 4096,
				Color.RED
			)
		await get_tree().create_timer(0.5, false).timeout
