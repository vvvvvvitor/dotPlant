extends "res://src/base_tile_map.gd"

const POP_SOUND: AudioStream = preload("res://res/sounds/weapons/blaster_shot.ogg")


func _ready() -> void:
	Audio.add_child(AudioBuilder.create(POP_SOUND).build_audio_stream_player(true, "Sounds"))
	for child in get_children():
		child.hide()
		child.process_mode = Node.PROCESS_MODE_DISABLED

	await get_tree().create_timer(1.0, false, false, false).timeout
	for child in get_children():
		child.show()
		child.process_mode = Node.PROCESS_MODE_INHERIT
		Audio.add_child(AudioBuilder.create(POP_SOUND).build_audio_stream_player(true, "Sounds"))
		await get_tree().create_timer(0.5, false, false, false).timeout
