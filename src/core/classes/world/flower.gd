extends Turret
class_name Flower


func _init() -> void:
	super()
	await ready
	update_sprite()
	set_physics_process(false)
	enabled = health != 1


func _damaged(damage: int, who: DamageBox2D) -> void:
	super(damage, who)
	enabled = health != 1
	update_sprite()


func update_sprite():
	var sprite = get_sprite()
	sprite.frame = round((sprite.hframes - 1.0) * float(health) / float(max_health))
