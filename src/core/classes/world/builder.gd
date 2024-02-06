extends Weapon
class_name Builder


const CONSTRUCTOR: PackedScene = preload("res://res/scenes/nodes/entities/projectiles/constructor.tscn")
@export var requirements: PackedStringArray = []
@export var ignore_force_areas: bool = false


func create_projectile(plant: PackedScene) -> Projectile2D:
	var constructor_instance: Projectile2D = CONSTRUCTOR.instantiate()
	constructor_instance.global_position = global_position
	constructor_instance.building = projectile
	constructor_instance.requirements = requirements
	constructor_instance.direction = global_rotation
	if ignore_force_areas:
		constructor_instance.add_to_group(ForceBox2D.IGNORE_GROUP)
	return constructor_instance
