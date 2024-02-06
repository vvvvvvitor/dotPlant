extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().new_wave.connect(show)
	get_parent().spawned.connect(hide)

