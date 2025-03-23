extends Control


func _on_confirm_pressed() -> void:
	var save_name: String = $VBoxContainer/SaveName.text
	if save_name and save_name != "":
		for schar in Global.special_chars:
			if save_name.contains(schar):
				# ERROR CODE CS1 -- INVALID CHARACTER DETECTED
				SignalBus.game_error.emit(Util.ERR_CODES.CS1)
				return
		for dir in DirAccess.get_directories_at("res://saves/"):
			if save_name == dir:
				# ERROR CODE CS2 -- MATCHING SAVE NAME DETECTED
				SignalBus.game_error.emit(Util.ERR_CODES.CS2)
				return
			else:
				SaveHandler.create_new_save($VBoxContainer/SaveName.text)
				return
	else:
		# ERROR CODE CS3 -- EMPTY SAVE NAME DETECTED
		SignalBus.game_error.emit(Util.ERR_CODES.CS3)


func _on_back_pressed() -> void:
	SignalBus.change_scene.emit("uid://ci3j2f2igok5a", Util.SCENE_CHANGE_TYPES.FB, false)
