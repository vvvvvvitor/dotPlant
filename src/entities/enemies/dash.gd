extends Node

@onready var collision_sound: AudioStreamPlayer2D = $"../../CollisionSound"


var direction = Vector2.ZERO
func _ready() -> void:
	owner.collided.connect(_on_collision)


func _enabled():
	direction = owner.global_position.direction_to(Core.get_player().global_position)


func _physics_process(delta: float) -> void:
	owner.velocity += direction * (owner.walk_speed) * ((1.0 - float(owner.health) / float(owner.max_health)) + 2.0) * delta


func _on_collision(col):
	if process_mode != PROCESS_MODE_DISABLED:
		if owner.is_on_wall():
			collision_sound.play()
			Canvas.screenshake(8, 16)
			get_parent().set_behaviour("Bouncing")
