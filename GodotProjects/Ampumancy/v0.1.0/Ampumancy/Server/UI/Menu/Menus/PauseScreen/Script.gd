extends Control

@onready var MainMenu: String = "res://Server/UI/Menu/Menus/Title Screen/Menu_TitleScreen.tscn"

var MenuOrDesk: bool


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GAME_PAUSE"):
		reset()


func _process(_delta: float) -> void:
	pass


func reset() -> void:
	$OptionsMenu.hide()
	$WardrobeMenu.hide()
	$ModsMenu.hide()
	$SaveMenu.hide()
	$Buttons.show()


func _on_options_pressed() -> void:
	$Buttons.hide()
	$OptionsMenu.show()


func _on_mods_pressed() -> void:
	$Buttons.hide()
	$ModsMenu.show()


func _on_menu_quit_pressed() -> void:
	MenuOrDesk = true
	$Buttons.hide()
	$SaveMenu.show()


func _on_desktop_quit_pressed() -> void:
	MenuOrDesk = false
	$Buttons.hide()
	$SaveMenu.show()


func _on_save_yes_pressed() -> void:
	Globals.add_playtime()
	SaveHandler.save_game(Globals.CurrentSave)
	menu_or_desk_quit()


func _on_save_no_pressed() -> void:
	menu_or_desk_quit()


func menu_or_desk_quit() -> void:
	if MenuOrDesk:
		SceneChanger.play_screen_transition("GameFadeToBlack")
	else:
		get_tree().quit()


func _on_save_back_pressed() -> void:
	$SaveMenu.hide()
	$Buttons.show()


func _on_back_pressed() -> void:
	visible = false
	get_tree().paused = false
