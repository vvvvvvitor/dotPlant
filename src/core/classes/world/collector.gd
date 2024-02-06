extends BaseBox2D
class_name Collector


signal stuff_collected_changed
signal collected


@export var group: String
@export var stuff_collected: int = 0:
	set(val):
		stuff_collected = clamp(val, 0, max_collected)
		stuff_collected_changed.emit()
@export var max_collected: int = 999
@export var store_data: bool = true
@export var free_collected: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_collection)


func _on_collection(body):
	if body.is_in_group(group):
		if store_data:
			stuff_collected += 1
		body.queue_free()
		collected.emit()
