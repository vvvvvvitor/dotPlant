extends Projectile2D
class_name LaserProjectile2D

#var last_ray_result: Dictionary
var line: Line2D

@export_flags_2d_physics var ray_collision_mask: int = 0xFFFFFFFF
@export var ray_length: int = 4096


func _init() -> void:
	super()
	free_after_death = false
	follow_direction_enabled = false


func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		line = get_node_by_class("Line2D")


func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state

	var query = create_query()
	var result = space_state.intersect_ray(query)
	if result:
		get_damagebox().get_collision_shape().shape.b = to_local(result.position)
		line.set_point_position(line.get_point_count() - 1, to_local(result.position))


func create_query() -> PhysicsRayQueryParameters2D:
	var direction_vector = Vector2(cos(direction), sin(direction))
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		direction_vector * ray_length,
		ray_collision_mask
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	return query


func __on_status_state_change(old: int, new: int):
	var desipate_tween = get_tree().create_tween()
	desipate_tween.tween_property(line, "width", 0, 1.0)
	await desipate_tween.finished
	super(old, new)
