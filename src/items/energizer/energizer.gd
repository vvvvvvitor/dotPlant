extends Weapon

@onready var collector: Collector = $Collector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collector.collected.connect(_on_collected)


func _on_collected():
	item_uses += 1
