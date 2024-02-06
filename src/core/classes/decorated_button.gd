extends Button
class_name DecoratedButton

@export var press_down: AudioBuilder
@export var press_release: AudioBuilder
@export var press_disabled: AudioBuilder
@export var press_toggle: AudioBuilder


func _init() -> void:
	button_up.connect(_on_button_press_up)
	focus_entered.connect(_on_button_focus)


func _on_button_press_up():
	if press_release:
		Audio.add_child(press_release.build_audio_stream_player(true, "Sounds"))


func _on_button_focus():
	if disabled:
		Audio.add_child(press_disabled.build_audio_stream_player(true, "Sounds"))
