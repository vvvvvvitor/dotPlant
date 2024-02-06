extends BaseBox2D
class_name Attractor2D

@export var pull_force: float = 128

var bodies: Array[PhysicsEntity2D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_enter)
	body_exited.connect(_on_body_exit)


func _physics_process(delta: float) -> void:
	for body: PhysicsEntity2D in bodies:
		body.velocity += body.global_position.direction_to(global_position) * pull_force * delta


func _on_body_enter(body):
	if body is PhysicsEntity2D:
		set_physics_process(true)
		bodies.append(body)


func _on_body_exit(body):
	bodies.erase(body)
	if bodies.is_empty():
		set_physics_process(false)
