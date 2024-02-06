extends WorldEntity2D

@onready var eye: CharacterBody2D = $Eye
@onready var attack_tree: Node = $AttackTree
@onready var hit_floor: AudioStreamPlayer = $HitFloor



func _init() -> void:
	set_collision_mask_value(1, false)
	z_index = -3


func _ready() -> void:
	physics_state_changed.connect(_on_floor)
	eye.status_state_changed.connect(_on_eye_death)

	velocity.y -= 512
	position = Vector2(448, 128)


func _process(_delta: float) -> void:
	if velocity.y > 0:
		set_collision_mask_value(1, true)
		z_index = -1
		set_process(false)


func _on_eye_death(_old, _new):
	attack_tree.process_mode = Node.PROCESS_MODE_DISABLED


func _on_floor(old, new):
	if new == PhysicsEntity2D.PHYSICS_STATES.IDLE:
		if !hit_floor.playing:
			hit_floor.play()

