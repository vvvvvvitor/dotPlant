extends Item
class_name Weapon

@export var projectile: PackedScene
@export_range(0, 360, 1.0, "radians") var spread:float = 0.0
@export var use_audio: AudioBuilder
@export var use_particles: GPUParticles2D


func _use(user: Node) -> void:
	var result = super(user)
	if result != false:
		if projectile:
			var projectile_instance: Projectile2D = create_projectile(projectile)
			get_tree().current_scene.add_child(projectile_instance)
			if use_particles:
				use_particles.restart()
				use_particles.emitting = true
			if use_audio:
				Audio.add_child(use_audio.build_audio_stream_player(true, "Sounds"))


func create_projectile(scene: PackedScene) -> Projectile2D:
	var projectile_instance: Projectile2D = scene.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.direction = global_rotation + randf_range(-spread, spread)
	return projectile_instance
