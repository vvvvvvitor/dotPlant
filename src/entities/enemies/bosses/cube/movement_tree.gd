extends BehaviourTree

@onready var dash_timer: Timer = $DashTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	dash_timer.timeout.connect(set_behaviour.bind("Dashing"))
	owner.health_changed.connect(_on_health_change)


func _on_health_change(old, new):
	if new < owner.max_health / 2:
		dash_timer.start()
		owner.health_changed.disconnect(_on_health_change)
