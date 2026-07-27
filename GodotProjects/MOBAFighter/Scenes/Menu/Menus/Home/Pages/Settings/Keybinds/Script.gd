extends MenuPage

@onready var action_list = $Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
@onready var input_button_scene = preload("res://Scenes/Menu/Buttons/InputMap/Button_InputMap.tscn")

var phys_suffix: String = " - Physical"

var remapping: bool = false
var action_to_remap = null
var remapping_button: InputMapper = null

var input_actions: Dictionary = {
	"move_up": "Move Up",
	"move_left": "Move Left",
	"move_down": "Move Down",
	"move_right": "Move Right",
	"interact1": "Interact",
	"interact2": "Secondary Interact",
	"crouch": "Crouch",
	"run": "Run",
	"dash": "Dash",
	"jump": "Jump",
	"ability1": "Ability 1",
	"ability2": "Ability 2",
	"ability3": "Ability 3",
	"ability4": "Ability 4"
}

func _ready() -> void:
	_create_action_list()


func _create_action_list() -> void:
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		queue_free()
	
	for action: StringName in input_actions:
		if not action.contains("ui"):
			var button: InputMapper = input_button_scene.instantiate()
			button.action = action
			var action_label: Label = button.find_child("ActionLabel")
			var input_label: Label = button.find_child("InputLabel")
			
			var events: Array[InputEvent] = InputMap.action_get_events(action)
			if events.size() > 0:
				input_label.text = events[0].as_text().trim_suffix(phys_suffix)
			else:
				input_label.text = "None"
			
			action_label.text = input_actions[action]
			
			action_list.add_child(button)
			button.add_input.pressed.connect(_on_input_button_pressed.bind(button, action))


func _on_input_button_pressed(button: InputMapper, action: StringName) -> void:
	if !remapping:
		remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("InputLabel").text = "Press a key to bind."


func _input(event: InputEvent) -> void:
	if remapping:
		if event is InputEventKey or (event is InputEventMouseButton and event.is_pressed()):
			if !event.as_text().contains("Escape"):
				if event is InputEventMouseButton and event.double_click: # Prevents any mouse inputs from being recorded as double-click events.
					event.double_click = false
				InputMap.action_add_event(action_to_remap, event) # Adds the pressed key to the list of events bound to this button's action
			
			remapping_button.input_label.text = "" # Resets the input bind label.
			for i in InputMap.action_get_events(action_to_remap): # Iterates through each item in the input list and adds their names to the label.
				remapping_button.input_label.text = (remapping_button.input_label.text + ", " + i.as_text()).trim_prefix(", ").trim_suffix(phys_suffix)
			remapping_button.add_input.focus_exited.emit() # Ensures that the add input button gets toggled off.
			
			remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()


func _on_reset_pressed() -> void:
	for mapper: InputMapper in action_list.get_children():
		mapper._on_reset_inputs_pressed()


func _on_back_pressed() -> void:
	pass # Replace with function body.
