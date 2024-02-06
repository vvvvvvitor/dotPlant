extends RichTextLabel


func _ready() -> void:
	var player: WorldEntity2D = Core.get_player()
	player.status_state_changed.connect(_on_new_state)


func _on_new_state(old, new):
	if new == Entity2D.DEAD:
		var player: WorldEntity2D = Core.get_player()
		for time in player.free_delay:
			text = "[center][wave]Rebuilding... " + str(player.free_delay - time) + "[/wave][/center]"
			await get_tree().create_timer(1.0).timeout
