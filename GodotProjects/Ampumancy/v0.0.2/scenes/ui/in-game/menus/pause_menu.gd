extends Control


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PAUSE"):
		pause_game()


func pause_game() -> void:
	get_tree().paused = not get_tree().paused
	visible = not visible


func _on_back_pressed() -> void:
	pause_game()


func _on_settings_pressed() -> void:
	$Pause/Buttons.hide()
	$Settings.show()


func _on_outfits_pressed() -> void:
	$Pause/Buttons.hide()
	$Outfit.show()


func _on_save_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	pass
