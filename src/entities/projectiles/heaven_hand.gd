extends Projectile2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void: pass

func __on_status_state_change(old: int, new: int):
	await get_tree().create_timer(1.0, false).timeout
	super(old, new)
	queue_free()
