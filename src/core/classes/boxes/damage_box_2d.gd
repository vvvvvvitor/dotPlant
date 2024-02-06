extends BaseBox2D
class_name DamageBox2D

signal hit(hit_box: HitBox2D)

@export var damage: int = 1
@export var knockback_multiplier: float = 32.0

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	area_entered.connect(__on_area_enter)


func __on_area_enter(area: Area2D) -> void:
	if area is HitBox2D:
		if area.get_parent() is Entity2D && !area.get_parent().can_take_damage: return
		area.damaged.emit(damage, self)
		var knockback_result = (damage * knockback_multiplier) * area.knockback_multiplier
		if area.get_parent() is CharacterBody2D:
			area.get_parent().velocity += Vector2(sign(global_position.direction_to(area.global_position).x), -0.5) * knockback_result

		hit.emit(area)
