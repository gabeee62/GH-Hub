extends Control


func _on_new_game_pressed() -> void:
	pass # Replace with function body.


func _on_load_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	$TitleButtons.visible = false
	$Options.visible = true
	$Graphics.visible = false
	$Audio.visible = false
	$Settings.visible = false


func _on_graphics_pressed() -> void:
	$TitleButtons.visible = false
	$Options.visible = false
	$Graphics.visible = true
	$Audio.visible = false
	$Settings.visible = false


func _on_audio_pressed() -> void:
	$TitleButtons.visible = false
	$Options.visible = false
	$Graphics.visible = false
	$Audio.visible = true
	$Settings.visible = false


func _on_settings_pressed() -> void:
	$TitleButtons.visible = false
	$Options.visible = false
	$Graphics.visible = false
	$Audio.visible = false
	$Settings.visible = true


func _on_back_pressed() -> void:
	$TitleButtons.visible = false
	$Options.visible = true
	$Graphics.visible = false
	$Audio.visible = false
	$Settings.visible = false


func _on_quit_pressed() -> void:
	pass # Replace with function body.
