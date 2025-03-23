extends Control

var new_save_scene_path: String = "uid://bqbvdt3xkyhfp"
var choose_save_scene_path: String = "uid://dsxc1jcpy3xf7"
var options_menu_path: String = "uid://di3tn0h6wnuuy"


func _on_new_game_pressed() -> void:
	SignalBus.change_scene.emit(new_save_scene_path, Util.SCENE_CHANGE_TYPES.FB, false)


func _on_continue_game_pressed() -> void:
	if DirAccess.get_directories_at(Global.save_dir_path).size() > 1:
		SignalBus.change_scene.emit(choose_save_scene_path, Util.SCENE_CHANGE_TYPES.FB, false)
	else:
		# ERROR CODE TS1 -- NO SAVES DETECTED
		SignalBus.game_error.emit(Util.ERR_CODES.TS1)


func _on_options_pressed() -> void:
	SignalBus.change_scene.emit(options_menu_path, Util.SCENE_CHANGE_TYPES.FB, false)


func _on_quit_game_pressed() -> void:
	SignalBus.quit_game.emit(false, false)
