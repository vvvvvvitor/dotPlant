extends CanvasLayer


func _ready() -> void:
	hide()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PAUSED:
		hide()
	elif what == NOTIFICATION_UNPAUSED:
		show()
