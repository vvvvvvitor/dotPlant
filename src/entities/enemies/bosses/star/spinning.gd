extends BehaviourTree


func _enabled():
	owner.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	owner.up_direction = Vector2.DOWN
	owner.velocity.y = 0
	owner.gravity = 0
