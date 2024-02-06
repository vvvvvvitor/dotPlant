extends VBoxContainer

const PRESSED = preload("res://res/resources/audios/pressed.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_settings()


func build_settings():
	for option in Settings.options:
		match typeof(option.value):
			TYPE_BOOL:
				var new_check_box = CheckBox.new()
				new_check_box.name = option.name
				new_check_box.text = option.display_name
				new_check_box.flat = true
				new_check_box.pressed.connect(_on_press.bind(new_check_box, option))
				add_child(new_check_box)
				new_check_box.set_pressed_no_signal(option.value)

				var new_button_audio: ButtonAudio = ButtonAudio.new()
				new_button_audio.press_down = PRESSED
				new_check_box.add_child(new_button_audio)
			TYPE_OBJECT:
				var new_menu_button: MenuButton = MenuButton.new()
				var popup: PopupMenu = new_menu_button.get_popup()

				popup.transparent_bg = true
				popup.transparent = true
				new_menu_button.name = option.name
				new_menu_button.text = option.display_name

				for possible_option in option.options:
					popup.add_item(possible_option.display_name)

				popup.id_pressed.connect(_on_option_selected.bind(option))
				add_child(new_menu_button)


func _on_press(button, option):
	option.set_value(button.button_pressed)


func _on_option_selected(id, option):
	option.set_value(option.options[id])
