extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = owner.get_parent().name
