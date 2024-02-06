extends Node2D
class_name Item


signal uses_changed


@export var item_display_name: String
@export var item_icon_display: Texture2D
@export var item_uses: int = 1:
	set(val):
		item_uses = val
		uses_changed.emit()
@export var usable: bool = true
@export var infinite: bool = false


func _use(user: Node):
	if !infinite:
		if item_uses != 0:
			item_uses -= 1
			if usable:
				if item_uses == 0:
					queue_free()
		else: return false


func get_timer() -> Timer:
	for child in get_children():
		if child is Timer:
			return child
	return
