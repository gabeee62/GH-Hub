extends Timer


func _on_timeout() -> void:
	if Globals.PLAYER and Globals.SAVE.AUTOSAVE:
		SaveHandler.save_to_disk(Globals.SAVE)
		$CanvasLayer/AutoSaveLabel/AnimationPlayer.play("autosave")


func stop_saving() -> void:
	stop()
	$CanvasLayer/AutoSaveLabel/AnimationPlayer.stop()
	$CanvasLayer/AutoSaveLabel.self_modulate = Color.TRANSPARENT
