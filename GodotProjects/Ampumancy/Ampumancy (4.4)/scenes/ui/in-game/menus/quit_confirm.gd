extends Control


func _on_desk_quit_pressed() -> void:
	get_tree().quit()


func _on_title_quit_pressed() -> void:
	AutoSave.stop_saving()
	SceneChanger.change_scene("res://scenes/ui/menus/TitleScreen.tscn")
