extends Node


@export var follow_area: TargetArea2D


func _ready() -> void:
	follow_area.target_added.connect(_on_target_added)


func _enabled():
	if !follow_area.targets.is_empty():
		get_parent().set_behaviour("Spinning")


func _physics_process(delta: float) -> void:
	var tilemap: TileMap = get_tree().current_scene
	if tilemap:
		var middle = Vector2(-128, -343)
		owner.velocity += owner.global_position.direction_to(middle) * 916 * delta


func _on_target_added(target: Node):
	get_parent().set_behaviour("Spinning")
