extends Area2D

@onready var printer_screen: CanvasLayer = $PrinterScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_player_enter)
	body_exited.connect(_on_player_exit)

	printer_screen.visible = false


var prev_pos: Vector2 = Vector2.ZERO
func _on_player_enter(body):
	if body.is_in_group("_Player"):
		printer_screen.visible = true
		prev_pos = get_viewport().get_camera_2d().position
		get_viewport().get_camera_2d().position.x = 64


func _on_player_exit(body):
	if body.is_in_group("_Player"):
		printer_screen.visible = false
		if get_viewport().get_camera_2d():
			get_viewport().get_camera_2d().position.x = prev_pos.x
