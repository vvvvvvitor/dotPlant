extends Node
class_name ButtonAudio

@export var press_down: AudioBuilder
@export var press_release: AudioBuilder
@export var press_disabled: AudioBuilder
@export var press_toggle: AudioBuilder


func _ready() -> void:
	get_parent().button_up.connect(_on_button_press_up)
	get_parent().focus_entered.connect(_on_button_focus)
	get_parent().pressed.connect(_on_button_press)


func _on_button_press_up():
	if press_release:
		Audio.add_sound(press_release, true)


func _on_button_focus():
	if get_parent().disabled:
		Audio.add_sound(press_disabled, true)


func _on_button_press():
	if press_down:
		Audio.add_sound(press_down, true)
