extends CanvasLayer


func play_screen_transition(transition: StringName) -> void:
	$AnimationPlayer.play(transition)


func test_message() -> void:
	print("TEST MESSAGE")


func change_scene(path: String) -> void:
	if FileAccess.file_exists(path):
		get_tree().change_scene_to_file(path)


func load_level() -> void:
	change_scene(Globals.CurrentSave.CurrentZone)


func pause_game() -> void:
	get_tree().paused = true


func unpause_game() -> void:
	get_tree().paused = false
