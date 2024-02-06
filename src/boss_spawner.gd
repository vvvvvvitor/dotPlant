extends Spawner

const ENDING: PackedScene = preload("res://res/scenes/rooms/ending.tscn")

@onready var timer_screen: CanvasLayer = $TimerScreen
signal new_wave


func _ready() -> void:
	new_wave.connect(_on_new_wave)
	Core.boss_defeated.connect(_on_boss_defeat)

	new_wave.emit()
#	Core.boss_spawner_ready.emit()


func _on_boss_defeat(_boss_name):
	if spawn_list.is_empty():
		get_tree().change_scene_to_packed(ENDING)
		return
	new_wave.emit()


func _on_new_wave():
	get_timer().start()
	get_timer().start()
