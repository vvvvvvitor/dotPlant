extends BehaviourTree


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.health_changed.connect(_on_new_health)


func _on_new_health(old, new):
	if new < owner.max_health / 2:
		get_parent().set_behaviour("Phase2")
		owner.health_changed.disconnect(_on_new_health)
