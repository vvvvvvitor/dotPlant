extends Projectile2D

@export var building: PackedScene
@export var requirements: PackedStringArray = []


func _physics_process(delta: float) -> void:
	do_physics(delta)
	move_and_slide()


func _process(delta: float) -> void: pass


func check_tile_requirements(col_data) -> bool:
	if !requirements.is_empty():
		if col_data is KinematicCollision2D:
			var col = col_data.get_collider()
			if col is TileMap:
				var tile: TileData = col.get_cell_tile_data(0, col.local_to_map(global_position - col_data.get_normal() * 4))
				if tile:
					return tile.get_custom_data("material") in requirements
	return false


func _on_hit(col_data):
	if col_data is KinematicCollision2D:
		if is_on_wall():
			velocity.x = 32 * sign(col_data.get_normal().x)
	if physics_state == PHYSICS_STATES.IDLE:
		if !requirements.is_empty():
			if !check_tile_requirements(col_data):
				velocity.y -= 128
				return
		var building_instance = building.instantiate()
		building_instance.global_position = col_data.get_position()
		get_tree().current_scene.add_child(building_instance)
		super(col_data)
