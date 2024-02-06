@tool
extends WorldEntity2D
class_name Projectile2D


@export var lifetime:float = 10.0
@export var speed:float:
	set(val):
		speed = val
		velocity *= val
		if Engine.is_editor_hint():
			queue_redraw()
@export var acceleration:float:
	set(val):
		acceleration = val
		if Engine.is_editor_hint():
			queue_redraw()
@export var follow_direction_enabled: bool = true
@export_range(0, 360, 1.0, "radians") var direction:float = 0:
	set(val):
		direction = val
		if follow_direction_enabled:
			rotation = snappedf(direction, PI / follow_direction) if follow_direction != 0 else direction
		velocity = Vector2(cos(direction), sin(direction)) * speed
		queue_redraw()
@export_range(0.0, 4.0) var follow_direction: float = 4

@export_category("Decoration")
@export var end_particles: ParticlesBuilder
@export var hit_sound: AudioBuilder


static func clear_projectiles():
	Core.get_tree().call_group("_projectile", "queue_free")


func _init() -> void:
	if !Engine.is_editor_hint():
		collided.connect(_on_hit)
		add_to_group("_projectile")

		await ready
		for child: Node in get_children():
			if child is DamageBox2D:
				child.hit.connect(_on_hit)


var end_particles_instance: OneShotGPUParticles2D
func _ready() -> void:
	if !Engine.is_editor_hint():
		direction = direction

		if end_particles:
			end_particles_instance = end_particles.build_gpu_particles_2d()
		await get_tree().create_timer(lifetime, false, false, false).timeout
		health = -1


func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		do_physics(delta)
		move_and_slide()


func _process(delta: float) -> void:
	if get_slide_collision_count() != 0:
		hide()


func _on_hit(col_data):
	health -= 1
	if health == 0:
		collided.disconnect(_on_hit)


func __on_status_state_change(old: int, new: int):
	if end_particles_instance:
		end_particles_instance.global_position = global_position
		get_tree().current_scene.add_child(end_particles_instance)
	if hit_sound:
		var hit_sound_instance = hit_sound.build_audio_stream_player_2d(global_position, 900, true, "Sounds")
		get_tree().current_scene.add_child(hit_sound_instance)
	super(old, new)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_line(Vector2.ZERO, Vector2(cos(direction), sin(direction)) * speed, Color.BLUE)
