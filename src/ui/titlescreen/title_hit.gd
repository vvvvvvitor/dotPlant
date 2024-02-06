extends Node2D

const ENERGY: PackedScene = preload("res://res/scenes/nodes/entities/energy.tscn")


func _enter_tree() -> void:
	var hitbox = get_hitbox()
	if hitbox:
		get_hitbox().damaged.connect(_damaged)
		get_hitbox().damaged.connect(_damaged_blink)


func get_hitbox() -> HitBox2D:
	for node in get_children():
		if node is HitBox2D:
			return node
	return


func _damaged(_damage: int, who: DamageBox2D) -> void:
	var energy_instance = ENERGY.instantiate()
	energy_instance.global_position = who.global_position
	get_tree().current_scene.add_child.call_deferred(energy_instance)



func _damaged_blink(damage: int, _who: DamageBox2D) -> void:
	if damage > 0:
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
