extends Control


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


func _on_back_pressed() -> void:
	$Settings.reset()
	$Buttons.show()


func _on_new_save_back_pressed() -> void:
	$NewSave.reset()
	$Buttons.show()


func _on_continue_back_pressed() -> void:
	$Continue.reset()
	$Buttons.show()


func _on_settings_back_pressed() -> void:
	$Settings.reset()
	$Buttons.show()


func _on_settings_child_back_pressed() -> void:
	$Settings.reset()
	$Settings.show()
