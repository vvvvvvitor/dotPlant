extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("action_main"):
		get_parent().set_behaviour("Released")
