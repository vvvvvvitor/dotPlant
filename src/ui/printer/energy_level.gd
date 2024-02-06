extends ProgressBar

@onready var amount: Label = $Amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.collector_set

	var collector: Collector = owner.collector

	max_value = collector.max_collected
	collector.stuff_collected_changed.connect(_on_collected.bind(collector))


func _on_collected(collector):
	value = collector.stuff_collected
	amount.text = str(collector.stuff_collected) + "/" + str(collector.max_collected)
