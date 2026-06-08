@tool # This decorator tells the editor to run the script even if the game isn't running (good for previews and testing).
# If you're using it, it has to go at the very top of the script.

# Tool scripts can be a little finnicky, though. If you're noticing that your variables aren't updating correctly with the script,
# try closing the scene's (not the script) tab and reopening it. The scene needs to reload the script to update properly.

extends Button # This extension tells Godot what base scene (or resource) this one inherits from.
# (Remember, scenes can only inherit scenes, and resources can only inherit resources. Can't mix the two)

# Export variables are useful for more than just saving data and testing.
# You can also use exports to edit a scene's child nodes even when you can't actually see them.

# For example: if you took out these export variables below and added this scene into your app, 
# you wouldn't be able to change anything about the label, not even the text.

# The way you get around this is by using these export variables, then setting the label's properties
# to match the variables in the script (see tool_process()).

# General tip: if you don't know what a certain node, property, or function does, you can command + click it
# to pull up its full documentation (as long as it's from the base Godot toolbox).

@export var ButtonText: String # Just a simple string. Whatever you want the button to say is put here.
@export var TextSettings: LabelSettings = LabelSettings.new() # The label's font, size, outline, etc.

@export var NormalTextColor: Color = "ffffff" # These color variables all have a default color, but because they are exports you can still change them. If you undo the change, they will go back to the specified default.
@export var HoveredTextColor: Color = "ffff00"
@export var PressedTextColor: Color = "808080"


func _process(_delta: float) -> void:
	
	if not Engine.is_editor_hint(): # Tests to see if the script is being run in the editor or in the app.
		running_process()
	else:
		tool_only_process()
	
	tool_process()


func running_process() -> void: # Put things you only want to happen when the app is running in here
	pass


func tool_process() -> void: # Put things you want to happen in the editor and in the app here.
	if $Label.position.y < 0:
		$Label.position.y = 0
	if ButtonText != $Label.text: # This if statement makes sure that the text is only changed if it doesn't match the ButtonText variable.
		$Label.text = ButtonText
	if $Label.label_settings != TextSettings: # Same here with TextSettings.
		$Label.label_settings = TextSettings


func tool_only_process() -> void: # Put things that you only want to happen in the editor here.
	pass


func _on_mouse_entered() -> void: # Any function you see with this green sign to left of it means it is connected to a node's signal. You can click on the sign to see what signal and node it's connected to.
	
	$AnimationPlayer.play("MouseHoverPulse") # Tells the AnimationPlayer node in the scene to play the specified animation.
	# P.S. Make sure to learn about AnimationPlayers. They're incredibly useful and can cut hundreds of lines of code if used optimally.
	
	$Label.self_modulate = HoveredTextColor # The self_modulate variable allows you to change the label's
	# color without affecting its children (if it had any). If you used the normal modulate variable, everything
	# under the label would also change colors with it.


func _on_mouse_exited() -> void: # Don't worry about changing things in these bottom functions for now.
	$AnimationPlayer.stop()
	$Label.position.y -= 4
	$Label.self_modulate = NormalTextColor


func _on_button_down() -> void:
	$AnimationPlayer.stop()
	$Label.self_modulate = PressedTextColor
	$Label.position.y += 4


func _on_button_up() -> void:
	$Label.self_modulate = NormalTextColor
	$Label.position.y -= 4
