extends Node

var runtime_flags: PackedInt32Array = [
	1 if OS.get_name() == "Web" else 0,
	0,
	OS.has_feature("debug")
]

enum FlagNames {
	IS_WEB,
	SKIP_BOOT,
	DEBUG
}

signal boss_spawner_ready
signal boss_defeated(boss_name: StringName)
signal boss_spawned(boss_name: StringName)
signal runtime_flag_changed(flag: FlagNames)


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func get_player() -> PhysicsEntity2D:
	return get_tree().get_first_node_in_group("_Player")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused


func set_runtime_flag(flag: FlagNames, value: int):
	runtime_flags[flag] = value
	runtime_flag_changed.emit(flag)


func get_runtime_flag(flag: FlagNames):
	return runtime_flags[flag]
