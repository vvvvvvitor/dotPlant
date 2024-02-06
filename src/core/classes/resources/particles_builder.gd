extends Resource
class_name ParticlesBuilder

@export var amount: int = 8
@export var texture: Texture2D
@export var one_shot: bool = true
@export var lifetime: float = 1.0
@export_range(0.0, 1.0) var explosiveness: float = 0
@export var process_material: ParticleProcessMaterial
@export var h_frames: int = 0


static func create(particles_process_material: ParticleProcessMaterial, particles_texture: Texture2D, particles_amount: int = 8, particles_one_shot: bool = true, particles_explosiveness: float = 0.0, particles_lifetime: float = 1.0) -> ParticlesBuilder:
	var new_burst = ParticlesBuilder.new()
	new_burst.amount = particles_amount
	new_burst.process_material = particles_process_material
	new_burst.texture = particles_texture
	new_burst.lifetime = particles_lifetime
	new_burst.explosiveness = particles_explosiveness
	return new_burst


func build_gpu_particles_2d() -> OneShotGPUParticles2D:
	var new_burst = OneShotGPUParticles2D.new()
	new_burst.amount = amount
	new_burst.process_material = process_material
	new_burst.texture = texture
	new_burst.lifetime = lifetime
	new_burst.one_shot = one_shot
	new_burst.explosiveness = explosiveness
	new_burst.material = CanvasItemMaterial.new()
	new_burst.material.particles_animation = bool(h_frames)
	new_burst.material.particles_anim_h_frames = h_frames
	return new_burst
