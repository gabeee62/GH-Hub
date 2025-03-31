extends Control


func reset() -> void:
	hide()


func _on_confirm_start_pressed() -> void:
	SaveHandler.create_new_save($Menu/SaveName.text, $Menu/PlayerName.text)
	SceneChanger.change_scene(Globals.SAVE.CURRENT_LVL)
