extends BaseBox2D
class_name ForceBox2D

const IGNORE_GROUP: String = "_NoForceApplied"

var bodies: Array[CharacterBody2D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_enter)
	body_exited.connect(_on_body_exit)


func _physics_process(delta: float) -> void:
	for body in bodies:
		body.velocity.y *= 0.9
		body.velocity.y -= 1028 * delta


func _on_body_enter(body):
	if !body.is_in_group(IGNORE_GROUP):
		bodies.append(body)
		if !is_physics_processing():
			set_physics_process(true)


func _on_body_exit(body):
	body.velocity.y *= 0.5
	bodies.erase(body)
	if bodies.is_empty():
		set_physics_process(false)
