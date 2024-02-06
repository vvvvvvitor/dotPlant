extends Node

@onready var star_step: AudioStreamPlayer2D = $"../../StarStep"


func _ready() -> void:
	owner.wings_destroyed.connect(get_parent().set_behaviour.bind("Spinning"))


func _physics_process(delta: float) -> void:
	if !star_step.playing:
		star_step.play()
		star_step.pitch_scale = clamp(owner.velocity.x * 0.01, 0.6, 1.1)
	owner.velocity += (owner.up_direction.rotated(PI/2)) * -owner.walk_speed * ((1.0 - float(owner.wings.size()) / float(5)) + 1.0) * delta
