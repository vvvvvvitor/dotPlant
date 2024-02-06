extends Label


func _ready() -> void:
	owner.executed.connect(_on_execute)


func _on_execute(result: PackedStringArray):
	text += result[0] + " >> " + result[1] + "\n"
