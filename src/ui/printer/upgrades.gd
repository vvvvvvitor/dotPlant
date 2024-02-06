extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade: Upgrade in owner.upgrades:
		var new_button: Button = Button.new()
		new_button.text = "$" + str(upgrade.cost)
		new_button.icon = upgrade.icon
		new_button.tooltip_text = upgrade.name
		new_button.pressed.connect(_on_pressed.bind(upgrade))
		upgrade.cost_changed.connect(_on_new_cost.bind(new_button, upgrade))
		add_child(new_button)


func _on_pressed(upgrade: Upgrade) -> void:
	owner.increase_player_stat(upgrade)


func _on_new_cost(btn, upgrade):
	btn.text = "$" + str(upgrade.cost)
