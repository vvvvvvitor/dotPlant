extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


func _process(delta: float) -> void:
	global_position = get_parent().global_position
