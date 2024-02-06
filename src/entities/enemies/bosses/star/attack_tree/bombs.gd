extends Node

const PROJECTILE = preload("res://res/scenes/nodes/entities/projectiles/falling_star.tscn")

@onready var bomb_timer: Timer = $BombTimer


func _ready() -> void:
	bomb_timer.timeout.connect(_on_bomb)
	owner.wings_destroyed.connect(_on_new_health)


func _on_bomb():
	if round(owner.up_direction.y) == 1:
		var projetile_instance = PROJECTILE.instantiate()
		projetile_instance.global_position = owner.global_position
		projetile_instance.direction = owner.up_direction.angle()
		get_tree().current_scene.add_child(projetile_instance)


func _on_new_health():
	bomb_timer.wait_time = 4
	if owner.health_changed.is_connected(_on_new_health):
		owner.health_changed.disconnect(_on_new_health)
