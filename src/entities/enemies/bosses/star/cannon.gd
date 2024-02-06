extends Node2D

const PROJECTILE = preload("res://res/scenes/nodes/entities/projectiles/energy_ball.tscn")

@onready var attack_timer: Timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().status_state_changed.connect(_on_new_status)
	attack_timer.timeout.connect(_on_attack)


func _on_new_status(old, new):
	attack_timer.start()


func _on_attack():
	var projectile_instance = PROJECTILE.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.direction = global_rotation - PI / 2
	get_tree().current_scene.add_child(projectile_instance)
