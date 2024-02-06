extends Node

@onready var collision_sound: AudioStreamPlayer2D = $"../../CollisionSound"


var direction: Vector2 = Vector2(1, -1)
func _ready() -> void:
	owner.collided.connect(_on_collision)
	owner.velocity = direction * owner.walk_speed


func _physics_process(delta: float) -> void:
	owner.velocity += direction.normalized() * (owner.walk_speed) * ((1.0 - float(owner.health) / float(owner.max_health)) + 1.0) * delta


func _on_collision(col: KinematicCollision2D):
	if owner.is_on_wall():
		if !collision_sound.playing:
			collision_sound.play()
		Canvas.screenshake()
		direction += col.get_normal()
