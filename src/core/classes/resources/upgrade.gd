@tool
extends Resource
class_name Upgrade

signal cost_changed

@export var name: String
@export var icon: Texture2D
@export var property: String
@export var value: int
@export var cost: int:
	set(val):
		cost = val
		cost_changed.emit()
