extends Node2D

const PROJECTILE: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/droplet.tscn")

@onready var sprinkle_timer: Timer = $SprinkleTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprinkle_timer.timeout.connect(_on_sprinkle)


func _on_sprinkle():
	var projectile_instance: Projectile2D = PROJECTILE.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.health = 999
	projectile_instance.get_node("DamageBox2D").damage = -1
	projectile_instance.direction = randf_range(-(PI / 2) - 0.5, -(PI / 2) + 0.5)
	get_tree().current_scene.add_child(projectile_instance)
