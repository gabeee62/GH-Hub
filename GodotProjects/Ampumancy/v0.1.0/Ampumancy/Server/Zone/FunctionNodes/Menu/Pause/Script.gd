extends Control


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_mods_pressed() -> void:
	pass # Replace with function body.


func _on_menu_quit_pressed() -> void:
	SaveHandler.save_game()
	# TODO: Make scene changer and transition to main menu


func _on_desktop_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	visible = false
	get_tree().paused = false
