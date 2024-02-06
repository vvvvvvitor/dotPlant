@tool
extends WorldEntity2D
class_name Turret


@export var starter_health: int = 1
@export var projectile: PackedScene
@export var enabled: bool = true
@export var attack_time: float = 1.0
@export var spawn_y_offset: int = 24


func _init() -> void:
	await ready
	health = starter_health
	var target_area: TargetArea2D = get_target_area()
	_update(target_area)


func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		do_physics(delta)
		move_and_slide()


func _action(target: Node, _target_area: TargetArea2D) -> void:
	if is_instance_valid(target):
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = global_position + Vector2(0, -spawn_y_offset)
		projectile_instance.direction = atan2(
			projectile_instance.global_position.direction_to(target.global_position).y,
			projectile_instance.global_position.direction_to(target.global_position).x
		)
		get_tree().current_scene.add_child(projectile_instance)


func get_target_area() -> TargetArea2D:
	for child in get_children():
		if child is TargetArea2D:
			return child
	return


func _update(target_area: TargetArea2D = null):
	if enabled:
		var target: Node = null
		if target_area:
			target = target_area.get_target()
		_action(target, target_area)
	if get_tree():
		await get_tree().create_timer(attack_time, false, false, false).timeout
		_update(target_area)
