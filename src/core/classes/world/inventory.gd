extends Node2D
class_name Inventory

const ITEM_CHANGE_SOUND: AudioStream = preload("res://res/sounds/item_change.ogg")

signal primary_item_changed(to_index: int)
signal item_used


func _init() -> void:
	child_exiting_tree.connect(_on_item_exit)


func _ready() -> void:
	update_items()


func _unhandled_input(event: InputEvent) -> void:
	if get_child_count() != 0:
		if event.is_action_pressed("action_switch_left"):
			move_item(-1, 0)
		if event.is_action_pressed("action_switch_right"):
			move_item(0, -1)
		if event.is_action_pressed("action_secondary"):
			var item_timer = get_child(0).get_timer()
			if item_timer:
				if !item_timer.is_stopped():
					return
				if !item_timer.one_shot:
					item_timer.timeout.connect(get_child(0)._use.bind(get_parent()))
				item_timer.start()
			get_child(0)._use(get_parent())
			item_used.emit()
		if event.is_action_released("action_secondary"):
			var item_timer: Timer = get_child(0).get_timer()
			if item_timer:
				if !item_timer.one_shot:
					item_timer.stop()
				if item_timer.timeout.is_connected(get_child(0)._use):
					item_timer.timeout.disconnect(get_child(0)._use)


func add_item(node: Item):
	var item_list = get_children()
	item_list.erase(node)

	for item: Item in item_list:
		if item.name == node.name:
			item.item_uses += 1
			node.queue_free()
			return
	add_child(node)
	update_items()


func move_item(child_idx: int = 0, to_idx: int = -1):
	Audio.add_child(AudioBuilder.create(ITEM_CHANGE_SOUND, -5).build_audio_stream_player(true, "Sounds"))
	var item_timer: Timer = get_child(0).get_timer()
	if item_timer:
		if item_timer.timeout.is_connected(get_child(0)._use):
			item_timer.timeout.disconnect(get_child(0)._use)
	move_child(get_child(child_idx), to_idx)
	update_items()
	primary_item_changed.emit(to_idx)


func update_items():
	for child in get_children():
		child.process_mode = Node.PROCESS_MODE_INHERIT if child.get_index() == 0 else Node.PROCESS_MODE_DISABLED
		child.visible = child.get_index() == 0


func _on_item_exit(node: Node):
	await node.tree_exited
	primary_item_changed.emit(get_child_count() - 1)
	update_items()
