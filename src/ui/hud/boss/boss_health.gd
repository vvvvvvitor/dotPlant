extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	var boss: WorldEntity2D = owner.get_parent()
	boss.health_changed.connect(_on_health_change)
	boss.max_health_changed.connect(_on_max_changed)

	await get_tree().create_timer(0.01).timeout
	max_value = boss.max_health
	value = boss.health


func _on_health_change(old, new):
	value = new


func _on_max_changed(new):
	max_value = new
