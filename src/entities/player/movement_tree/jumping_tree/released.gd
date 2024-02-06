extends Node


func _enabled():
	if owner.velocity.y < 0:
		owner.velocity.y *= 0.5
