extends BaseBox2D
class_name HitBox2D


signal damaged(damage: int, who: DamageBox2D)
@export var knockback_multiplier: float = 1.0
