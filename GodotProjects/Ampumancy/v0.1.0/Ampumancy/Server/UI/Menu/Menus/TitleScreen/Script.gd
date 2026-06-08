extends Control

# TODO: Make title animations and fix title so it still appears above options, mod, and new game menus

@export var ForbiddenChars: Array[String] = ["!", "@", "#", "$", "%", "^", "&", "*", "*", "(", ")", "_", "=", "+", "[", "]", "{", "}", ";", ":", "'", "\"", "?", "\\", "|", ",", "<", ".", ">", "/", "`", "~"]

@onready var save_slot_scene: PackedScene = preload("res://Server/UI/Menu/Buttons/SaveSlot/UI_Menu_Button_SaveSlot.tscn")

@onready var Backgrounds: Array = [References.Background1, References.Background2, References.Background3, References.Background4, References.Background5, References.Background6, References.Background7, References.Background8]
@export var ScrollOffsetArray: Array

@onready var MainMenu: Control = $MainMenu
@onready var NewGameMenu: Control = $NewGameMenu
@onready var NewSaveName: TextEdit = $NewGameMenu/Menu/SaveName
@onready var LoadGameMenu: Control = $LoadGameMenu
@onready var SaveSlots: VBoxContainer = $LoadGameMenu/PanelMargin/Panel/ScrollBoxMargin/ScrollBox/SaveSlots
@onready var OptionsMenu: Control = $OptionsMenu
@onready var ModsMenu: Control = $ModsMenu


func _process(delta: float) -> void:
	background_scroll(delta)


func _ready() -> void:
	get_tree().paused = true
	Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW, Vector2.ZERO)
	SaveHandler.load_settings()
	on_first_launch()
	reset_to_main()
	set_save_slots()
	random_background()
	if Globals.Settings.ColdStart:
		Globals.Settings.ColdStart = false
		SceneChanger.play_screen_transition("LaunchFadeFromBlack")
	else:
		SceneChanger.play_screen_transition("FadeFromBlack")


func set_save_slots() -> void:
	if OS.is_debug_build():
		update_save_slots(SaveHandler.DebugLocation)
	update_save_slots(SaveHandler.SaveLocation)


func update_save_slots(location: String) -> void:
	for folder in DirAccess.open(location).get_directories():
		var save_slot: SaveSlotButton = save_slot_scene.instantiate()
		save_slot.DebugSlot = true if location == SaveHandler.DebugLocation else false
		save_slot.Data = ResourceLoader.load(location + folder + "/Save.tres")
		save_slot.connect("focused", _on_slot_focused)
		save_slot.set_label_text(folder)
		SaveSlots.add_child(save_slot)


func on_first_launch() -> void: # Initializes all necessary filestructures, default settings, etc. for the game to be ready to run.
	if Globals.Settings.FirstLaunch:
		Globals.Settings.FirstLaunch = false
		SaveHandler.save_settings()
		print("FIRST LAUNCH!")
		# TODO: Finish the rest of the first launch preparations


func random_background() -> void:
	var i: int = 0
	var para_layers: Array[Node] = $Background.get_children()
	var chosen_bg: int = RandomNumberGenerator.new().randi_range(1, 8)
	ScrollOffsetArray = References.ScrollOffsets[chosen_bg]
	for layer: Texture2D in Backgrounds[chosen_bg - 1]: # The number of parallax layer nodes is always >= the number of scroll values, so this loops by scroll value to avoid having to check for array sizes*
		para_layers[i].get_child(0).texture = layer
		i += 1


func background_scroll(delta: float) -> void:
	var para_layers: Array[Node] = $Background.get_children()
	var i: int = 0
	for value in ScrollOffsetArray: # *Same here
		para_layers[i].motion_offset.x += value * delta
		i += 1


# RESET FUNCTIONS
func reset_to_main() -> void: # Fully resets the title menu
	reset_play_menus()
	reset_to_options()
	OptionsMenu.hide()
	reset_to_mods()
	ModsMenu.hide()
	MainMenu.show()

func reset_play_menus() -> void: # Sets all values and positions for PlayMenu (NewGame and LoadGame) elements back to their default
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

func _on_play_back_pressed() -> void:
	reset_to_main()


# NEW GAME MENU INTERACTIONS
func _on_new_game_pressed() -> void:
	LoadGameMenu.hide()
	NewGameMenu.show()

func _on_new_start_pressed() -> void: # Creates a new save file, sets it to be the Global CurrentSave, and loads the game's first level
	if NewSaveName.text != "":
		for i in NewSaveName.text: # Checks to ensure save name doesn't contain forbidden characters
			for character in ForbiddenChars:
				if i == character:
					return # TODO: Add message to tell player why they can't make a save
		var NewSave: SaveData = SaveHandler.new_save(NewSaveName.text)
		Globals.CurrentSave = NewSave
		SceneChanger.play_screen_transition("MenuFadeToBlack")

func _on_new_back_pressed() -> void:
	reset_to_main()


# LOAD GAME MENU INTERACTIONS
func _on_load_game_pressed() -> void:
	MainMenu.hide()
	LoadGameMenu.show()

func _on_slot_focused(focused_slot: SaveSlotButton) -> void:
	for child: Node in SaveSlots.get_children():
		if child != focused_slot:
			child.DeleteStatus = 0

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
