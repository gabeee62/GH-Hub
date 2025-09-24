extends Control

signal save_and_quit()


func _notification(what: int) -> void:
	match what:
		Node.NOTIFICATION_PAUSED:
			hide()
			#reset()
		Node.NOTIFICATION_UNPAUSED:
			show()


func reset() -> void:
	# FIXME: All children are being hidden despite matching names
	for child: Control in get_children():
		if child.name != "PauseBG" or child.name != "Buttons":
			child.hide()
		else:
			child.show()


func _on_outfits_pressed() -> void:
	$Buttons.hide()
	$Outfit.show()


func _on_options_pressed() -> void:
	$Buttons.hide()
	$Options.show()


func _on_quit_pressed() -> void:
	save_and_quit.emit()
	get_tree().quit()


func _on_video_pressed() -> void:
	pass # Replace with function body.


func _on_audio_pressed() -> void:
	pass # Replace with function body.


func _on_controls_pressed() -> void:
	pass # Replace with function body.


func _on_options_back_pressed() -> void:
	pass # Replace with function body.


func _on_outfit_back_pressed() -> void:
	$Outfit.hide()
	$Buttons.show()
