extends TileMap

@export var song_layers: Array[AudioBuilder] = []



func _ready():
	Core.boss_spawned.connect(_on_boss_spawn)
	Core.boss_defeated.connect(_on_boss_defeat)

	for song in song_layers.size():
		Audio.add_soundtrack(song_layers[song])

	for layer in get_layers_count():
		if get_layer_name(layer).begins_with("_"):
			set_layer_modulate(layer, Color.TRANSPARENT)


func _use_tile_data_runtime_update(layer: int, _coords: Vector2i) -> bool:
	return get_layer_z_index(layer) != 2


func _tile_data_runtime_update(_layer: int, _coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_collision_polygons_count(0, 0)


func _on_boss_spawn(boss_name):
	for song in get_tree().get_nodes_in_group("Soundtrack"):
		song.volume_db = -80 * int(!song.name in [boss_name, "MainTheme"])


func _on_boss_defeat(boss_name):
	if get_tree():
		for song in get_tree().get_nodes_in_group("Soundtrack"):
			if song.name == boss_name:
				song.queue_free()
				break
