extends Node


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func add_soundtrack(soundtrack: AudioBuilder, always_process: bool = false) -> AudioStreamPlayer:
	var song = soundtrack.build_audio_stream_player(false, "Music")
	song.add_to_group("Soundtrack")
	add_child(song)
	return song


func add_sound(sound: AudioBuilder, always_process: bool = false) -> AudioStreamPlayer:
	var snd = sound.build_audio_stream_player(true, "Sounds")
	snd.add_to_group("Sound")
	snd.process_mode = Node.PROCESS_MODE_ALWAYS if always_process else Node.PROCESS_MODE_INHERIT
	add_child(snd)
	return snd


func free_soundtrack():
	get_tree().call_group("Soundtrack", "queue_free")


func _on_bus_option(old, new, option: Option):
	match option.name:
		"MuteSounds":
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), new)
		"MuteMusic":
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), new)
