extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene: Node = get_tree().current_scene
	if scene is TileMap:
		limit_left = scene.get_used_rect().position.x * scene.tile_set.tile_size.x
		limit_right = scene.get_used_rect().end.x * scene.tile_set.tile_size.x
		limit_top = scene.get_used_rect().position.y * scene.tile_set.tile_size.x
		limit_bottom = scene.get_used_rect().end.y * scene.tile_set.tile_size.x
