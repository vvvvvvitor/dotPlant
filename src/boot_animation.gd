extends AnimationPlayer

const RECOVERY_MODE: PackedScene = preload("res://res/scenes/rooms/main_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Core.get_runtime_flag(Core.FlagNames.SKIP_BOOT) == 1:
		get_tree().change_scene_to_packed.call_deferred(RECOVERY_MODE)
	play("Boot")


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if !is_playing():
			get_tree().change_scene_to_packed(RECOVERY_MODE)
