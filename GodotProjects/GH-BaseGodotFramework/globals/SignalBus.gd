extends Node

#              --- ABOUT ---
# This script provides global access to any
# important game signals. Useful for tramsmitting 
# signals between nodes that cannot interact
# directly within the tree.

signal pause_game()
signal quit_game(title_or_desktop: bool, save_game: bool)

signal game_error(err_code: Util.ERR_CODES)

signal main_started()

# CONTINUE FROM SAVE
signal save_chosen(num: int)

signal change_scene(filepath: String, transition_type: Util.SCENE_CHANGE_TYPES, save: bool)

signal cheat_entered(cheat_text: String)


func _ready() -> void:
	pause_game.get_name()
	game_error.get_name()
	main_started.get_name()
	save_chosen.get_name()
	change_scene.get_name()
	cheat_entered.get_name()
	quit_game.get_name()
