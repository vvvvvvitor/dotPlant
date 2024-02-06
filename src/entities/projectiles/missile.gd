extends Projectile2D

const EXPLOSION: PackedScene = preload("res://res/scenes/nodes/explosions/explosion_fire.tscn")


func _ready() -> void:
	super()
	velocity = Vector2(cos(direction), sin(direction)) * -(speed * 0.5)


func _physics_process(delta: float) -> void:
	velocity += Vector2(cos(direction), sin(direction)) * speed * delta

	super(delta)


func __on_status_state_change(old: int, new: int):
	var explosion_instance = EXPLOSION.instantiate()
	explosion_instance.global_position = global_position
	get_tree().current_scene.add_child.call_deferred(explosion_instance)
	super(old, new)
