extends HBoxContainer


@onready var weapon_name: Label = $WeaponName
@onready var weapon_ammo: Label = $WeaponAmmo


func _ready() -> void:
	var player: WorldEntity2D = Core.get_player()
	var inventory: Inventory = player.get_inventory()

	update_info(0, inventory)
	inventory.primary_item_changed.connect(update_info.bind(inventory))
	inventory.item_used.connect(update_info.bind(0, inventory))


func update_info(direction: int, inventory: Inventory) -> void:
	var item = inventory.get_child(0)
	if item:
		var item_uses = item.item_uses

		weapon_name.text = item.item_display_name
		weapon_ammo.text = str(item_uses).pad_zeros(3) if !item.infinite else "---"
		if !inventory.get_child(0).uses_changed.is_connected(update_info):
			inventory.get_child(0).uses_changed.connect(update_info.bind(0, inventory))
