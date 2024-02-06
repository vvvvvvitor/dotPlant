extends BehaviourTree


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_main"):
		if owner.physics_state == PhysicsEntity2D.PHYSICS_STATES.IDLE:
			set_behaviour("Jumping")


func _process(delta: float) -> void:
	get_animation_tree()["parameters/Walking/TimeScale/scale"] = (owner.velocity.x * owner.ground_friction) * 0.025 * int(owner.is_on_floor())
