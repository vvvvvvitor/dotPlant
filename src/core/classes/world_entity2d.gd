extends PhysicsEntity2D
class_name WorldEntity2D


@export var walk_speed: int = 640
@export var jump_force: int = 196
@export var inventory: Inventory


func _enter_tree() -> void:
	status_state_changed.connect(__on_status_state_change)

	var hitbox = get_hitbox()
	if hitbox:
		get_hitbox().damaged.connect(_damaged)
		get_hitbox().damaged.connect(_damaged_blink)


func get_behaviour_tree() -> BehaviourTree:
	for node in get_children():
		if node is BehaviourTree:
			return node
	return


func get_inventory() -> Inventory:
	return inventory


func get_sprite() -> Sprite2D:
	for node in get_children():
		if node is Sprite2D:
			return node
	return


func get_hitbox() -> HitBox2D:
	for node in get_children():
		if node is HitBox2D:
			return node
	return


func get_damagebox() -> DamageBox2D:
	for node in get_children():
		if node is DamageBox2D:
			return node
	return


func get_node_by_class(type: String) -> Node:
	for child in get_children():
		if child.is_class(type):
			return child
	return


func _damaged(damage: int, who: DamageBox2D) -> void:
	health -= damage


func _damaged_blink(damage: int, who: DamageBox2D) -> void:
	if damage > 0:
		modulate = Color.RED
		await get_tree().create_timer(0.1, false, false, false).timeout
		modulate = Color.WHITE


func __on_status_state_change(old: int, new: int):
	if new == DEAD:
		modulate = Color.AQUA
		set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
		set_physics_process(false)
