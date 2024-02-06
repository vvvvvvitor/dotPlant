extends Resource
class_name Option

signal value_changed(old, new)

var name: StringName = "option"
var display_name: String = "Option"
var value:
	set(val):
		value = val
var function: Callable


static func create(value, function: Callable, name: StringName = "Option", display_name: String = "Option") -> Option:
	var new_option: Option = Option.new()
	new_option.function = function
	new_option.name = name
	new_option.display_name = display_name
	new_option.value = value
	return new_option


func set_value(val):
	value = val
	value_changed.emit(value, val)
	function.call(value)
