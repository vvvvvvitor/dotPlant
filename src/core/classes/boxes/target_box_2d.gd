extends BaseBox2D
class_name TargetArea2D

signal target_added(target: Node)
signal target_removed(target: Node)

enum TargettingModes {
	CLOSEST,
	PRIORITIZE_PLAYER,
	PLAYER
}

@export var targetting_mode: TargettingModes = TargettingModes.CLOSEST
var targets: Array[Node] = []


func _ready() -> void:
	area_entered.connect(_on_target_enter)
	area_exited.connect(_on_target_leave)

## DEPRECATED
func get_closest() -> Node:
	var distances: Array = []

	for target in targets:
		var distance = global_position.distance_to(target.global_position)
		distances.append(distance)
	return targets[distances.find(distances.min())] if targets.size() != 0 else null


func get_target() -> Node:
	match targetting_mode:
		TargettingModes.CLOSEST:
			var distances: Array = []

			for target in targets:
				var distance = global_position.distance_to(target.global_position)
				distances.append(distance)

			return targets[distances.find(distances.min())] if !targets.is_empty() else null
		TargettingModes.PRIORITIZE_PLAYER:
			var distances: Array = []

			for target in targets:
				var distance = global_position.distance_to(target.global_position)
				distances.append(distance)

			if !targets.is_empty():
				return targets[distances.find(distances.min())] if !Core.get_player() in targets else Core.get_player()
			return
		TargettingModes.PLAYER:
			if !targets.is_empty():
				return Core.get_player() if !Core.get_player() in targets else null
			return
	return


func _on_target_enter(area: Area2D):
	if area is HitBox2D:
		targets.append(area.get_parent())
		target_added.emit(area.get_parent())


func _on_target_leave(area: Area2D):
	if area is HitBox2D:
		targets.erase(area.get_parent())
		target_removed.emit(area.get_parent())

