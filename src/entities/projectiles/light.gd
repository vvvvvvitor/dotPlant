extends Projectile2D

const CAVE: PackedScene = preload("res://res/scenes/rooms/cave.tscn")

@onready var light_particles: CPUParticles2D = $LightParticles
@onready var waking_sound: AudioStreamPlayer = $WakingSound

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	light_particles.emitting = true
	light_particles.finished.connect(get_tree().change_scene_to_packed.bind(CAVE))
	waking_sound.play()

var desired_dir: float = 1.0
func _physics_process(delta: float) -> void:
	var center = Vector2(0, -64)
	var dir = atan2(global_position.direction_to(center).y, global_position.direction_to(center).x)
	desired_dir = lerp_angle(desired_dir, dir, 0.1)

	velocity += Vector2(cos(desired_dir), sin(desired_dir)) * speed * delta

	do_physics()
	move_and_slide()
