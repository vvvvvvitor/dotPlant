extends Label

signal t_changed

@onready var boss_timer: Timer = $"../../../../BossTimer"

var t = 0:
	set(val):
		t = val
		t_changed.emit()


func _ready() -> void:
	owner.new_wave.connect(_on_new_wave)
	t_changed.connect(_on_new_t)


func _on_new_wave():
	var tween = get_tree().create_tween()
	t = boss_timer.wait_time
	tween.tween_property(self, "t", 0, boss_timer.wait_time)


func _on_new_t():
	text = str(round(t)).pad_zeros(2)
