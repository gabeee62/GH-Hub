extends CanvasLayer


func play_screen_transition(transition: StringName) -> void:
	$AnimationPlayer.play(transition)


func load_level() -> void:
	SaveHandler.load_game()
