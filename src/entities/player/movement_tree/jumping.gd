extends BehaviourTree


func _enabled():
	super()
	owner.velocity.y -= owner.jump_force


func _physics_process(delta: float) -> void:
	var hor_input: float = Input.get_axis("move_left", "move_right")
	owner.velocity.x += hor_input * owner.walk_speed * delta

	if owner.is_on_floor():
		get_parent().set_behaviour("Idle")
