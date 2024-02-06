extends Option
class_name OptionList

var options: Array[Option]


static func create_list(options_arr: Array[Option], name: StringName = "Option", display_name: String = "Option") -> Option:
	var new_option_list: OptionList = OptionList.new()
	new_option_list.name = name
	new_option_list.display_name = display_name

	new_option_list.options = options_arr
	new_option_list.value = new_option_list.options[0]

	return new_option_list


func set_value(val):
	value = val
	value_changed.emit(value, val)
	val.function.call(val.value)
