extends Control

const CURSOR = preload("res://res/textures/ui/cursor.png")
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	draw_texture(CURSOR, round(get_local_mouse_position()))
