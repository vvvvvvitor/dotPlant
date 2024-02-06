extends GPUParticles2D

@export var heal_color: Color
@export var damage_color: Color

@onready var damage_label: Label = $SubViewport/Damage
@onready var sub_viewport: SubViewport = $SubViewport


func _ready() -> void:
	get_parent().damaged.connect(_on_damage)
	texture = sub_viewport.get_texture()


func _on_damage(damage, who):
	damage_label.text = str(-damage)
	damage_label.label_settings.font_color = damage_color if damage > 0 else heal_color
	restart()
	emitting = true
