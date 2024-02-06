extends Area2D


func _ready() -> void:
	body_entered.connect(_on_energy_enter)


func _on_energy_enter(body):
	body.queue_free()
	get_parent().item_uses += 1
