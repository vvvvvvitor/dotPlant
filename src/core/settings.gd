extends Node


var options: Array = [
	Option.create(
		false,
		(func(val): AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), val)),
		"MuteMusic",
		"Mute Music"
	),
	Option.create(
		false,
		(func(val): AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), val)),
		"MuteSounds",
		"Mute Sounds"
	),
	OptionList.create_list(
		[
			Option.create(
				DisplayServer.WINDOW_MODE_WINDOWED,
				(func(val):
					DisplayServer.window_set_mode(val)
					DisplayServer.window_set_size(Vector2i(416, 256))
					),
				"WindowSize1x",
				"1x"
			),
			Option.create(
				DisplayServer.WINDOW_MODE_WINDOWED,
				(func(val):
					DisplayServer.window_set_mode(val)
					DisplayServer.window_set_size(Vector2i(832, 512))
					),
				"WindowSize2x",
				"2x"
			),
			Option.create(
				DisplayServer.WINDOW_MODE_FULLSCREEN,
				(func(val): DisplayServer.window_set_mode(val)),
				"WindowSizeFull",
				"Fullscreen"
			),
		], "WindowSize", "Window Size"
	)
]


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func get_option(option_name: StringName) -> Option:
	for option in options:
		if option.name == option_name:
			return option
	return
