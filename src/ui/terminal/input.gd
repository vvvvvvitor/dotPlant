extends LineEdit


func _ready() -> void:
	text_submitted.connect(_on_submit)


func  _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		await get_tree().create_timer(0.1).timeout
		grab_focus()


func _on_submit(command):
	var result = Debug.execute(command)
	owner.executed.emit(result)
	clear()
