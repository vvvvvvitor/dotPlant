extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.runtime_flag_changed.connect(_on_runtime_flag_changed)

	visible = Core.get_runtime_flag(Core.FlagNames.IS_WEB) == 0


func _on_runtime_flag_changed(flag: int):
	visible = Core.get_runtime_flag(Core.FlagNames.IS_WEB) == 0
