extends HBoxContainer

const ITEM_PANEL: PackedScene = preload("res://res/scenes/nodes/ui/hud/item_panel.tscn")


func _ready() -> void:
	var player: WorldEntity2D = Core.get_player()
	var inventory: Inventory = player.get_inventory()

	inventory.primary_item_changed.connect(update_info.bind(inventory))
	inventory.child_exiting_tree.connect(_on_item_exit)
	inventory.child_entered_tree.connect(_on_item_enter)
	build_display(inventory)
	get_child(0).custom_minimum_size = Vector2.ONE * 24


func build_display(inventory: Inventory):
	for item: Item in inventory.get_children():
		var item_panel_instance = ITEM_PANEL.instantiate()
		item_panel_instance.get_node("ItemIcon").texture = item.item_icon_display
		add_child(item_panel_instance)


func update_info(direction: int, inventory: Inventory) -> void:
	move_child(get_child(get_child_count() - 1 if direction == 0 else 0), direction)

	if !is_inside_tree():
		return

	for item in get_children():
		if item.get_index() == 0:
			var size_increase_tween = get_tree().create_tween()
			if size_increase_tween:
				size_increase_tween.set_trans(Tween.TRANS_QUAD)
				size_increase_tween.tween_property(item, "custom_minimum_size", Vector2.ONE * 24, 0.1)
		else:
			var size_decrease_tween = get_tree().create_tween()
			if size_decrease_tween:
				size_decrease_tween.set_trans(Tween.TRANS_QUAD)
				size_decrease_tween.tween_property(item, "custom_minimum_size", Vector2.ONE * 16, 0.05)


func _on_item_exit(node: Node):
	var panel = get_child(node.get_index())
	if panel:
		get_child(node.get_index()).queue_free()


func _on_item_enter(item: Item):
	var item_panel_instance = ITEM_PANEL.instantiate()
	item_panel_instance.get_node("ItemIcon").texture = item.item_icon_display
	add_child(item_panel_instance)
