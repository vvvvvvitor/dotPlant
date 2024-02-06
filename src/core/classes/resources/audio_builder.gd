extends Resource
class_name AudioBuilder

@export var name: String = "Audio"
@export var stream: AudioStream
@export_range(-80, 24, 0.001, "suffix:dB") var volume: float = 0
@export_range(0.01, 4.0) var pitch_scale: float = 1
@export_range(0.0, 4.0) var pitch_randomness: float = 0


static func create(audio_stream: AudioStream, audio_volume: float = 0, audio_pitch: float = 1, audio_pitch_randomness: float = 0) -> AudioBuilder:
	var new_audio_builder: AudioBuilder = AudioBuilder.new()
	new_audio_builder.stream = audio_stream
	new_audio_builder.volume = audio_volume
	new_audio_builder.pitch_scale = audio_pitch
	new_audio_builder.pitch_randomness = audio_pitch_randomness
	return new_audio_builder


func build_audio_stream_player(free_on_finish: bool = true, audio_bus: StringName = "Master") -> AudioStreamPlayer:
	var new_audio_stream_player: AudioStreamPlayer = AudioStreamPlayer.new()
	new_audio_stream_player.autoplay = true
	new_audio_stream_player.stream = stream
	new_audio_stream_player.volume_db = volume
	new_audio_stream_player.pitch_scale = pitch_scale + randf_range(-pitch_randomness, pitch_randomness)
	new_audio_stream_player.bus = audio_bus
	new_audio_stream_player.name = name
	if free_on_finish:
		new_audio_stream_player.finished.connect(new_audio_stream_player.queue_free)
	return new_audio_stream_player


func build_audio_stream_player_2d(position, distance, free_on_finish: bool = true, audio_bus: StringName = "Master") -> AudioStreamPlayer2D:
	var new_audio_stream_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	new_audio_stream_player.stream = stream
	new_audio_stream_player.volume_db = volume
	new_audio_stream_player.pitch_scale = pitch_scale + randf_range(-pitch_randomness, pitch_randomness)
	new_audio_stream_player.autoplay = true
	new_audio_stream_player.position = position
	new_audio_stream_player.max_distance = distance
	new_audio_stream_player.name = name
	new_audio_stream_player.bus = audio_bus
	if free_on_finish:
		new_audio_stream_player.finished.connect(new_audio_stream_player.queue_free)
	return new_audio_stream_player
