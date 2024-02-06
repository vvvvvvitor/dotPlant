extends WorldEntity2D

const PLAYER_HIT = preload("res://res/sounds/player_hit.ogg")
@onready var starter_pos: Vector2 = global_position

@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var death_particles: CPUParticles2D = $DeathParticles
@onready var hand_anchor: Node2D = $HandAnchor
@onready var invs_timer: Timer = $InvsTimer
@onready var smoke_particles: GPUParticles2D = $SmokeParticles


func _ready() -> void:
	health_changed.connect(_on_health_change)
	status_state_changed.connect(_on_exit)
	Core.boss_defeated.connect(_on_boss_death)

	invs_timer.timeout.connect(_on_dam)


func respawn_player():
	global_position = starter_pos
	can_take_damage = true
	health = max_health
	status_state = ALIVE
	set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
	set_physics_process(true)
	velocity = Vector2.ZERO
	get_sprite().visible = true
	hand_anchor.visible = true
	smoke_particles.restart()
	smoke_particles.emitting = false


func _damaged(damage: int, who: DamageBox2D) -> void:
	if damage > 0:
		Canvas.freeze()
		Canvas.screenshake(4, 8)
		Audio.add_child(AudioBuilder.create(PLAYER_HIT).build_audio_stream_player(true, "Sounds"))
	super(damage, who)
	can_take_damage = false
	invs_timer.start()


func _on_exit(old, new):
	if new == DEAD:
		invs_timer.stop()
		death_particles.emitting = true
		get_sprite().visible = false
		hand_anchor.visible = false
		death_sound.play()
		await get_tree().create_timer(free_delay, false).timeout
		free_delay = clamp(free_delay + 5, 0, 15)
		respawn_player()


func _on_dam():
	can_take_damage = true


func _on_boss_death(_boss_name):
	pass

func _on_health_change(_old, new):
	smoke_particles.emitting = new < 5
