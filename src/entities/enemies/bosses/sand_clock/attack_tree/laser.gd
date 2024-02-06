extends Node2D

const PROJECTILE = preload("res://res/scenes/nodes/entities/projectiles/laser.tscn")

@onready var attack_timer: Timer = $AttackTimer

var last_laser_direction: float = randf_range(0, PI)


func _ready() -> void:
	owner.health_changed.connect(_on_health_changed)
	attack_timer.timeout.connect(_on_attack)

	last_laser_direction = randf_range(0, PI)


func _process(delta: float) -> void:
	queue_redraw()
	visible = attack_timer.time_left < 2 && !attack_timer.is_stopped()


func _on_attack():
	var projectile_instance = PROJECTILE.instantiate()
	var direction = owner.global_position.direction_to(Core.get_player().global_position)
	projectile_instance.direction = last_laser_direction
	owner.add_child(projectile_instance)

	last_laser_direction = randf_range(0, PI)


func _on_health_changed(old, new):
	if new < owner.max_health * 0.5:
		attack_timer.start()
		owner.health_changed.disconnect(_on_health_changed)


func _draw() -> void:
	var inv = get_global_transform().inverse()
	draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())

	var line_direction = Vector2(cos(last_laser_direction), sin(last_laser_direction))
	draw_line(
		owner.global_position,
		global_position + (line_direction * 4096),
		Color.RED
	)
