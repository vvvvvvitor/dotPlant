extends Node

var execute_history: PackedStringArray = []

func execute(command: String, base: Object = self) -> PackedStringArray:
	var expression: Expression = Expression.new()
	var result = expression.parse(command)
	var args: PackedStringArray = []

	if result != OK:
		args = [base.name, expression.get_error_text()]
	result = expression.execute([], self)
	if expression.has_execute_failed():
		args = [base.name, "Command failed for an unknown reason!"]
	args = [base.name, result]
	execute_history.append(command)
	return args


func room(path: String) -> String:
	var result = get_tree().change_scene_to_file("res://res/scenes/rooms/" + path + ".tscn")
	match result:
		ERR_CANT_OPEN: return "Room not found!"
		ERR_CANT_CREATE: return "Can't instantiate room!"
	return "Changed room to " + path + "!"


func set_flag(flag_name: String, value: int) -> String:
	Core.set_runtime_flag(Core.FlagNames.get(flag_name), value)
	return "Set " + flag_name + " to " + str(value) + "!"


func get_framerate() -> String:
	return str(Engine.get_frames_per_second())

func spawn(path: String, properties: Dictionary = {}, position: Vector2 = Core.get_player().global_position + Vector2(0, -32)):
	var result = load("res://res/scenes/nodes/entities/" + path + ".tscn")
	if !result:
		return "Entity not found!"

	result = result.instantiate()
	result.global_position = position
	get_tree().current_scene.add_child(result)

	for property in properties:
		result.set(property, properties.get(property))

	return "Instantiated " + path + "!"


func fullscreen() -> String:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_FULLSCREEN)
	return "Set fullscreen!"
