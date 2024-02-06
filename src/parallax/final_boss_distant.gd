extends ParallaxLayer

@onready var angel_sprite: Sprite2D = $AngelSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.boss_defeated.connect(_on_boss_death)


func _on_boss_death(boss_name):
	get_parent().move_child(self, get_index() + 1)
	angel_sprite.scale += Vector2.ONE * 0.2
	if boss_name == "Eye": queue_free()
