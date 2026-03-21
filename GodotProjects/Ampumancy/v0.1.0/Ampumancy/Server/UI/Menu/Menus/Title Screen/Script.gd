extends Control

var ForbiddenChars: Array[String] = ["!", "@", "#", "$", "%", "^", "&", "*", "*", "(", ")", "_", "=", "+", "[", "]", "{", "}", ";", ":", "'", "\"", "?", "\\", "|", ",", "<", ".", ">", "/", "`", "~"]

@onready var save_slot_scene: PackedScene = preload("res://Server/UI/Menu/Buttons/SaveSlot/UI_Menu_Button_SaveSlot.tscn")

@onready var MainMenu: Control = $MainMenu
@onready var NewGameMenu: Control = $NewGameMenu
@onready var NewSaveName: TextEdit = $NewGameMenu/Menu/SaveName
@onready var LoadGameMenu: Control = $LoadGameMenu
@onready var SaveSlots: VBoxContainer = $LoadGameMenu/PanelMargin/Panel/ScrollBoxMargin/ScrollBox/SaveSlots
@onready var OptionsMenu: Control = $OptionsMenu
@onready var ModsMenu: Control = $ModsMenu


func _ready() -> void:
	reset_to_main()
	for folder in DirAccess.open(SaveHandler.SaveLocation).get_directories():
		var save_slot: SaveSlotButton = save_slot_scene.instantiate()
		save_slot.Data = ResourceLoader.load(SaveHandler.SaveLocation + folder + "/Save.tres")
		save_slot.set_label_text(folder)
		save_slot.set_playtime()
		SaveSlots.add_child(save_slot)


# RESET FUNCTIONS
func reset_to_main() -> void: # Fully resets the title menu.
	reset_play_menus()
	reset_to_options()
	OptionsMenu.hide()
	reset_to_mods()
	ModsMenu.hide()
	MainMenu.show()

func reset_play_menus() -> void: # Sets all values and positions for PlayMenu (NewGame and LoadGame) elements back to their default.
	$NewGameMenu/Menu/SaveName.text = ""
	NewGameMenu.hide()
	$LoadGameMenu/PanelMargin/Panel/ScrollBoxMargin/ScrollBox.scroll_vertical = 0
	LoadGameMenu.hide()

func reset_to_options() -> void:
	# Do reset stuff here
	OptionsMenu.show()

func reset_to_mods() -> void:
	# Do reset stuff here
	ModsMenu.show()


# PLAY MENU INTERACTIONS
func _on_play_pressed() -> void:
	MainMenu.hide()
	LoadGameMenu.show()

func _on_play_back_pressed() -> void: # TODO: Remove play menu stuff as it can be skipped using the load game menu
	reset_to_main()


# NEW GAME MENU INTERACTIONS
func _on_new_game_pressed() -> void:
	LoadGameMenu.hide()
	NewGameMenu.show()

func _on_new_start_pressed() -> void: # Creates a new save file, sets it to be the Global CurrentSave, and loads the game's first level.
	if NewSaveName.text != "":
		for i in NewSaveName.text: # Checks to ensure save name doesn't contain forbidden characters
			for character in ForbiddenChars:
				if i == character:
					return
		var NewSave: SaveData = SaveHandler.new_game(NewSaveName.text)
		Globals.CurrentSave = NewSave
		SceneChanger.play_screen_transition("MenuFadeToBlack") # TODO: Replace with separate transitions that are called when the game is ready

func _on_new_back_pressed() -> void:
	reset_to_main()


# LOAD GAME MENU INTERACTIONS
func _on_load_game_pressed() -> void:
	MainMenu.hide()
	LoadGameMenu.show()

func _on_load_back_pressed() -> void:
	reset_to_main()


# OPTIONS MENU INTERACTIONS
func _on_options_pressed() -> void:
	MainMenu.hide()
	OptionsMenu.show()

func _on_options_back_pressed() -> void:
	reset_to_main()


# GAMEPLAY MENU INTERACTIONS
func _on_gameplay_pressed() -> void:
	pass

func _on_gameplay_back_pressed() -> void:
	reset_to_options()


# VIDEO MENU INTERACTIONS
func _on_video_pressed() -> void:
	pass

func _on_video_back_pressed() -> void:
	reset_to_options()


# AUDIO MENU INTERACTIONS
func _on_audio_pressed() -> void:
	pass

func _on_audio_back_pressed() -> void:
	reset_to_options()


# MODS MENU INTERACTIONS
func _on_mods_pressed() -> void:
	MainMenu.hide()
	ModsMenu.show()

func _on_mods_back_pressed() -> void:
	reset_to_main()


# QUIT BUTTON
func _on_quit_pressed() -> void:
	get_tree().quit()
