extends BehaviourTree

@onready var attack_timer: Timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_timer.timeout.connect(_attack)


func _attack():
	set_behaviour(get_behaviours().pick_random().name)
