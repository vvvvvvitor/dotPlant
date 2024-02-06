extends Resource
class_name Product

signal sold_out

@export var icon: Texture2D
@export var name: String
@export_multiline var description: String
@export var item: PackedScene
@export var quantity: int = 999:
	set(val):
		quantity = val
		if quantity < 1:
			sold_out.emit()
@export var cost: int
