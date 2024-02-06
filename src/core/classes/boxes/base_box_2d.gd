extends Area2D
class_name BaseBox2D


func get_collision_shape() -> CollisionShape2D:
	for node in get_children():
		if node is CollisionShape2D:
			return node
	return
