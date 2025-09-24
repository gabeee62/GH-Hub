extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		toggle_pause()


func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
