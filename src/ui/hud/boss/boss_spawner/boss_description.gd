extends Label

const CLASSIFICATION_META_NAME: String = "type"

@onready var boss_spawner: Node2D = $"../../../.."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.boss_defeated.connect(update_description)


func update_description(_boss_name):
	if !boss_spawner.spawn_list.is_empty():
		var boss_scene_state: SceneState = boss_spawner.spawn_list[0].get_state()
		var boss_type: String
		for property in boss_scene_state.get_node_property_count(0):
			if boss_scene_state.get_node_property_name(0, property) == "metadata/" + CLASSIFICATION_META_NAME:
				boss_type = boss_scene_state.get_node_property_value(0, property)
		text = "Entity of type " + boss_type + " approaching in"
