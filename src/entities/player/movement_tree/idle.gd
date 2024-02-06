extends Node


func _physics_process(delta: float) -> void:
	var hor_input: float = Input.get_axis("move_left", "move_right")

	if hor_input != 0:
		get_parent().set_behaviour("Walking")
