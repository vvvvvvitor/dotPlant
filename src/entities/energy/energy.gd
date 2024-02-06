extends WorldEntity2D

const MAX_ENERGY_COUNT: int = 128
const COLLISION_SOUND: AudioStream = preload("res://res/sounds/clink.ogg")
const BOUNCE_VELOCITY: int = 64

static var energy_count: int = 0

var plays_sound: bool = true

@onready var clink_sound: AudioStreamPlayer2D = $ClinkSound


func _enter_tree() -> void:
	if energy_count > MAX_ENERGY_COUNT:
		queue_free()


func _ready() -> void:
	collided.connect(_on_collision)

	velocity.x = [BOUNCE_VELOCITY, -BOUNCE_VELOCITY].pick_random() * 0.5

	energy_count += 1
	plays_sound = energy_count < 24


func _exit_tree() -> void:
	energy_count -= 1


func _physics_process(delta):
	if get_slide_collision_count() != 0:
		collided.emit(get_last_slide_collision())

	velocity.x *= ground_friction
	velocity -= up_direction * gravity * delta

	move_and_slide()


func _on_collision(col: KinematicCollision2D):
	if plays_sound:
		clink_sound.play()
	velocity.x += col.get_normal().x * (BOUNCE_VELOCITY * 0.5)
	velocity.y += col.get_normal().y * BOUNCE_VELOCITY

