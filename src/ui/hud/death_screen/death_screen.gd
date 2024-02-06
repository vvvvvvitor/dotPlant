extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player: WorldEntity2D = Core.get_player()
	player.status_state_changed.connect(_on_new_state)

	visible = false


func _on_new_state(old, new):
	visible = new == Entity2D.DEAD
