extends Control

@onready var MainMenu: Control = $MainMenu
@onready var PlayMenu: Control = $PlayMenu
@onready var NewGameMenu: Control = $PlayMenu/NewGameMenu
@onready var LoadGameMenu: Control = $PlayMenu/LoadGameMenu
@onready var OptionsMenu: Control = $OptionsMenu
@onready var ModsMenu: Control = $ModsMenu


func reset() -> void:
	reset_new_menu()
	reset_load_menu()
	reset_play_menu()
	PlayMenu.hide()
	reset_options_menu()
	OptionsMenu.hide()
	reset_mods_menu()
	ModsMenu.hide()
	MainMenu.show()


func reset_play_menu() -> void:
	$PlayMenu/Buttons.show()
	NewGameMenu.hide()
	LoadGameMenu.hide()


func reset_new_menu() -> void:
	$PlayMenu/NewGameMenu/VBoxContainer/SaveName.text = ""


func reset_load_menu() -> void:
	pass


func reset_options_menu() -> void:
	pass


func reset_mods_menu() -> void:
	pass


func _on_play_pressed() -> void:
	MainMenu.hide()
	PlayMenu.show()


func _on_play_back_pressed() -> void:
	pass # Replace with function body.


func _on_new_game_pressed() -> void:
	$PlayMenu/Buttons.hide()
	$PlayMenu/NewGameMenu.show()


func _on_new_start_pressed() -> void:
	pass # Replace with function body.


func _on_new_back_pressed() -> void:
	reset_new_menu()


func _on_load_game_pressed() -> void:
	$PlayMenu/Buttons.hide()
	$PlayMenu/LoadGameMenu.show()


func _on_load_start_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	MainMenu.hide()
	OptionsMenu.show()


func _on_mods_pressed() -> void:
	MainMenu.hide()
	ModsMenu.show()


func _on_quit_pressed() -> void:
	get_tree().quit()
