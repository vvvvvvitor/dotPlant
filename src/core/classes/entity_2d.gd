extends CharacterBody2D
class_name Entity2D

signal status_state_changed(old:int, new:int)# Emmited when the current physics state changes.
signal health_changed(old: int, new: int) # Emmited when the health changes.
signal max_health_changed(new: int)

@export var free_delay:float = 0 # Delay before the entity gets freed.
@export var max_health:int = 1:
	set(val):
		max_health = val
		health_changed.emit(health, max_health)
		health = max_health
		max_health_changed.emit(max_health)
@export var free_after_death: bool = true
@export var can_take_damage: bool = true

var health:int = max_health:
	set(val):
		if can_take_damage:
			health_changed.emit(health, val)
			health = clamp(val, -999, max_health)
			if max_health < 0:
				return
			if health < 1:
				status_state = DEAD
				if free_delay > -1 && free_after_death:
					await get_tree().create_timer(free_delay, false).timeout
					queue_free()
var status_state:int = ALIVE:
	set(val):
		if status_state != val:
			status_state_changed.emit(status_state, val)
		status_state = val

enum {
	ALIVE,
	DEAD
}
