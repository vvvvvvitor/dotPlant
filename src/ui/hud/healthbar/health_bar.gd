extends ProgressBar

@onready var health_counter: Label = $HealthCounter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player: WorldEntity2D = Core.get_player()

	player.health_changed.connect(_on_health_change.bind(player))
	player.max_health_changed.connect(_on_max_changed.bind(player))

	max_value = player.max_health
	value = player.health

	health_counter.text = str(player.health).pad_zeros(2) + " / " + str(player.max_health).pad_zeros(2)


func _on_health_change(old, new, player):
	value = new
	health_counter.text = str(new).pad_zeros(2) + " / " + str(player.max_health).pad_zeros(2)


func _on_max_changed(new, player):
	max_value = new
	health_counter.text = str(player.health).pad_zeros(2) + " / " + str(new).pad_zeros(2)
