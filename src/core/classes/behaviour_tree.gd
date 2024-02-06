extends Node
class_name BehaviourTree

signal change_behaviour(behaviour_name:StringName)

const SET_METHOD_NAME = "_enabled"
const UNSET_METHOD_NAME = "_disabled"

const SPECIAL_TYPES:PackedStringArray = [
	"AnimationPlayer",
	"AnimationTree",
	"Timer"
]

var current_behaviour: StringName = ""


func _init() -> void:
	change_behaviour.connect(set_behaviour)


func _ready() -> void:
	disable_behaviours()
	if !get_parent() is BehaviourTree:
		set_first_behaviour()


func _enabled():
	set_first_behaviour()


func _disabled():
	disable_behaviours()


func has_behaviour(behaviour_name:StringName) -> bool:
	for behaviour in get_behaviours():
		if behaviour.name == behaviour_name:
			return true
	return false


func set_behaviour(behaviour_name: StringName, ignore_process_mode: bool = false) -> void:
	if !ignore_process_mode:
		if process_mode == PROCESS_MODE_DISABLED:
			return

	var animation_tree: AnimationTree = get_animation_tree()
	var animation_state_machine: AnimationNodeStateMachinePlayback
	var new_behaviour: Node = get_node(NodePath(behaviour_name))

	if animation_tree:
		animation_state_machine = animation_tree["parameters/playback"]

	if new_behaviour:
		if !current_behaviour.is_empty():
			var old_behaviour: Node = get_node(NodePath(current_behaviour))
			if old_behaviour.has_method(UNSET_METHOD_NAME):
				old_behaviour.call(UNSET_METHOD_NAME)
			old_behaviour.process_mode = Node.PROCESS_MODE_DISABLED
		new_behaviour.process_mode = Node.PROCESS_MODE_INHERIT
		if new_behaviour.has_method(SET_METHOD_NAME):
			new_behaviour.call(SET_METHOD_NAME)
		if animation_state_machine:
			animation_state_machine.travel(behaviour_name)
		current_behaviour = behaviour_name


func set_first_behaviour() -> void:
	if get_behaviour_count() != 0:
		set_behaviour(get_behaviours()[0].name, true)


func get_behaviour_count() -> int:
	return get_behaviours().size()


func get_behaviours_names() -> PackedStringArray:
	var names:PackedStringArray = []
	for behaviour in get_behaviours():
		names.append(behaviour.name)
	return names


func get_behaviour(behaviour_name:StringName) -> Node:
	for node in get_behaviours():
		if node.name == behaviour_name:
			return node
	return


func get_behaviours() -> Array[Node]:
	var behaviours:Array[Node] = []
	for node in get_children():
		if !node.get_class() in SPECIAL_TYPES:
			behaviours.append(node)
	return behaviours


var _last_anim_tree: AnimationTree
func get_animation_tree() -> AnimationTree:
	if is_instance_valid(_last_anim_tree):
		return _last_anim_tree

	for child in get_children():
		if child is AnimationTree:
			_last_anim_tree = child
			return child
	return


func disable_behaviours():
	for behaviour in get_behaviours():
		behaviour.process_mode = PROCESS_MODE_DISABLED
