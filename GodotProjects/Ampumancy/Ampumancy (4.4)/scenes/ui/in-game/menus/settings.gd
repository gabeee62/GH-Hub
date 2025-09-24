extends Control


func reset() -> void:
	$Buttons.show()
	$Video.reset()
	$Audio.reset()
	$Controls.reset()
	hide()


func _on_video_pressed() -> void:
	$Buttons.hide()
	$Video.show()


func _on_audio_pressed() -> void:
	$Buttons.hide()
	$Audio.show()


func _on_controls_pressed() -> void:
	$Buttons.hide()
	$Controls.show()
