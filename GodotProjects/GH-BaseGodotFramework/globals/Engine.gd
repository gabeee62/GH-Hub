extends Node


func _ready() -> void:
	SignalBus.main_started.connect(_on_main_started)
	SignalBus.pause_game.connect(_on_pause_game)
	SignalBus.cheat_entered.connect(_on_cheat_entered)
	SignalBus.quit_game.connect(_on_quit_game)


func _on_main_started():
	for i in Global.MAIN.boot_message():
		print(i)


func _on_cheat_entered(cheat_text: String):
	CheatHandler.process_command(cheat_text)


func _on_pause_game():
	get_tree().paused = not get_tree().paused


func _on_quit_game(title_or_desktop: bool, save_current_file: bool):
	if title_or_desktop:
		SignalBus.change_scene.emit("res://scenes/ui/menus/title_screen/title_screen.tscn", Util.SCENE_CHANGE_TYPES.FB, save_current_file)
		print("SYSTEM: Player has quit to the title menu!\n")
	else:
		if save_current_file:
			SaveHandler.save_to_disk()
		print("SYSTEM: Player has quit to desktop!\n")
		get_tree().quit()
