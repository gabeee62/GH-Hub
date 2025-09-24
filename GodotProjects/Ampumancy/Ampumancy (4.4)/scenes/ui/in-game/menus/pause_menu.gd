extends Control


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PAUSE"):
		reset()
		pause_game()


func pause_game() -> void:
	if visible:
		Globals.PLAY_START += Time.get_ticks_msec() - Globals.PAUSE_START
	else:
		Globals.PAUSE_START = Time.get_ticks_msec()
	visible = not visible
	get_tree().paused = not get_tree().paused


func reset() -> void:
	$Buttons.show()
	$Settings.reset()
	$Outfit.hide()
	$QuitConfirm.hide()


func _on_back_pressed() -> void:
	pause_game()


func _on_settings_pressed() -> void:
	$Buttons.hide()
	$Settings.show()


func _on_settings_back_pressed() -> void:
	reset()


func _on_outfit_pressed() -> void:
	$Buttons.hide()
	$Outfit.show()


func _on_outfit_back_pressed() -> void:
	reset()


func _on_save_pressed() -> void:
	SaveHandler.save_to_disk()


func _on_quit_pressed() -> void:
	$QuitConfirm.show()
	$Buttons.hide()


func _on_quit_back_pressed() -> void:
	reset()


func _on_video_pressed() -> void:
	$Settings/Video.show()
	$Settings/Buttons.hide()


func _on_video_back_pressed() -> void:
	$Settings/Video.reset()
	$Settings/Buttons.show()


func _on_audio_pressed() -> void:
	$Settings/Audio.show()
	$Settings/Buttons.hide()


func _on_controls_pressed() -> void:
	$Settings/Controls.show()
	$Settings/Buttons.hide()


func _on_audio_back_pressed() -> void:
	$Settings/Audio.reset()
	$Settings/Buttons.show()


func _on_controls_back_pressed() -> void:
	$Settings/Controls.reset()
	$Settings/Buttons.show()
