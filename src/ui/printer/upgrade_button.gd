extends Button

@export var property_name: String
@export var value: float
@export var cost: int = 10


func _ready() -> void:
	text = "$" + str(cost)

	for upgrade: Upgrade in owner.upgrades:
		var new_button: Button = Button.new()
		new_button.text = "$" + str(upgrade.cost)
		add_child(new_button)


func _pressed() -> void:
	if owner.collector.stuff_collected > cost:
		owner.increase_player_stat(property_name, value)
		owner.collector.stuff_collected -= cost
		cost *= 2
		text = "$" + str(cost)
