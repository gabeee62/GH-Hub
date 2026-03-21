extends CanvasLayer


func play_screen_transition(transition: StringName) -> void:
	$AnimationPlayer.play(transition)


func load_main_menu() -> void:
	get_tree().change_scene_to_file("res://Server/UI/Menu/Menus/Title Screen/Menu_TitleScreen.tscn")


func load_level() -> void:
	SaveHandler.load_game()
