extends Control


const ENDING_SONG: AudioStream = preload("res://res/sounds/music/a-happy-ending.wav")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.free_soundtrack()
	Audio.add_soundtrack(AudioBuilder.create(ENDING_SONG))
