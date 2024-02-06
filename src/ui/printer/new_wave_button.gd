extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void: pass
	#Core.boss_defeated.connect(_on_boss_defeat)
	#await Core.boss_spawner_ready
	#disabled = false


func _pressed() -> void:
	var spawner: Spawner = get_tree().get_first_node_in_group("_spawner")
	spawner.new_wave.emit()
	disabled = true


func _on_boss_defeat(_boss_name):
	disabled = false
