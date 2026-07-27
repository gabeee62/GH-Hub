extends Panel
class_name InputMapper

@export var action: StringName

@onready var defaults: Keybinds = preload("res://Data/Settings/Keybinds/Default.tres")
@onready var action_label: Label = $MarginContainer/HBoxContainer/ActionLabel
@onready var add_input: Button = $MarginContainer/HBoxContainer/AddInput
@onready var clear_inputs: Button = $MarginContainer/HBoxContainer/ClearInputs
@onready var input_label: Label = $MarginContainer/HBoxContainer/InputLabel
@onready var reset_inputs: Button = $MarginContainer/HBoxContainer/ResetInputs


func _on_clear_inputs_pressed() -> void:
	InputMap.action_erase_events(action)
	input_label.text = "None"


func _on_reset_inputs_pressed() -> void:
	var index: int
	for i in defaults.actions:
		if action == i:
			index = defaults.actions.find(i)
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, defaults.keys[index])
			input_label.text = InputMap.action_get_events(action)[0].as_text().trim_suffix(" - Physical")


func _on_input_type_pressed() -> void:
	pass # Replace with function body.


func _on_add_input_focus_exited() -> void:
	add_input.set_pressed_no_signal(false)
