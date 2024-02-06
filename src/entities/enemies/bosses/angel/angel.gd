extends Boss


func __on_status_state_change(old: int, new: int):
	super(old, new)
	Core.get_player().health = Core.get_player().max_health
	Core.get_player().can_take_damage = false
