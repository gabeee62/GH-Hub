extends Control


func _ready() -> void:
	$TitleCanvas.set_new_parallax_bg(randi_range(1, 8))


func reset() -> void:
	$Buttons.show()
	#$Title/SplashLabel.rand_splash_text()


func _on_start_new_pressed() -> void:
	$Buttons.hide()
	$NewSave.show()


func _on_continue_pressed() -> void:
	$Buttons.hide()
	$Continue.show()


func _on_settings_pressed() -> void:
	$Buttons.hide()
	$Settings.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_save_back_pressed() -> void:
	$NewSave.reset()
	reset()


func _on_continue_back_pressed() -> void:
	$Continue.reset()
	reset()


func _on_settings_back_pressed() -> void:
	$Settings.reset()
	reset()


func _on_settings_child_back_pressed() -> void:
	$Settings.reset()
	$Settings.show()
