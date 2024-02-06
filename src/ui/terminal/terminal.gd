extends CanvasLayer

signal executed(result: PackedStringArray)


func _init() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Core.get_runtime_flag(Core.FlagNames.DEBUG) == 1:
			visible = !visible
