extends Node

@export var follow_area: TargetArea2D


func _ready() -> void:
	owner.collided.connect(_on_collision)


func _enabled():
	owner.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	owner.up_direction = Vector2.DOWN
	owner.velocity.y = 0
	owner.gravity = 0


func _physics_process(delta: float) -> void:
	if !follow_area.targets.is_empty():
		owner.velocity += owner.global_position.direction_to(follow_area.get_target().global_position + Vector2(0, -128)) * 916 * delta
	else:
		var tilemap: TileMap = get_tree().current_scene
		if tilemap:
			var middle = Vector2(512, -64)
			owner.velocity += owner.global_position.direction_to(middle) * 916 * delta


func _on_collision(col: KinematicCollision2D):
	if owner.is_on_wall():
		owner.velocity = col.get_normal() * 32
