extends Sprite2D

@onready var explosion_player: AnimationPlayer = $ExplosionPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().status_state_changed.connect(_on_dead)


func _on_dead(old, new):
	explosion_player.play("Explode")
	get_parent().status_state_changed.disconnect(_on_dead)
