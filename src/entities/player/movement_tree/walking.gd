extends Node

const STEP_SOUND: AudioStream = preload("res://res/sounds/step.ogg")


func _physics_process(delta: float) -> void:
	var hor_input: float = Input.get_axis("move_left", "move_right")

	owner.velocity.x += hor_input * owner.walk_speed * delta

	if hor_input == 0:
		get_parent().set_behaviour("Idle")
