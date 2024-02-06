extends Projectile2D

const ENERGY: PackedScene = preload("res://res/scenes/nodes/entities/energy.tscn")


func _on_hit(col_data):
	var energy_instance = ENERGY.instantiate()
	energy_instance.global_position = global_position
	get_tree().current_scene.add_child(energy_instance)
	super(col_data)
