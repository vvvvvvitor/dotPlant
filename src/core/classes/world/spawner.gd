extends Node2D
class_name Spawner

signal spawned


@export var spawn_list: Array[PackedScene]


func _init() -> void:
	await ready
	add_to_group("_spawner")
	if get_timer():
		get_timer().timeout.connect(spawn)


func spawn_instance(scene: PackedScene):
	var instance = scene.instantiate()
	instance.global_position = global_position
	get_tree().current_scene.add_child(instance)


func get_timer() -> Timer:
	for child in get_children():
		if child is Timer:
			return child
	return


func spawn():
	spawned.emit()
	if spawn_list.size() != 0:
		spawn_instance(spawn_list[0])
		spawn_list.pop_front()
