extends Control

enum Menus {MAIN, PLAY, OPTIONS, MODS}
var ActiveMenu: Menus = Menus.MAIN

enum PlayMenus {LOAD, NEW}
var ActivePlay: PlayMenus = PlayMenus.LOAD

enum OptionsMenus {NONE, AUDIO, VIDEO}
var ActiveOptions: OptionsMenus = OptionsMenus.NONE

enum ModsMenus {NONE, MODS, PACKS}
var ActiveMods: ModsMenus = ModsMenus.NONE


@onready var Audio: Control = $AudioMenu
@onready var Load: Control = $LoadGameMenu
@onready var Main: Control = $MainMenu
@onready var Mods: Control = $ModsMenu
@onready var New: Control = $NewGameMenu
@onready var Options: Control = $OptionsMenu
@onready var Video: Control = $VideoMenu


func set_active_menu(active_menu: Control) -> void:
	for node: Control in [Main, Load, New, Options, Audio, Video, Mods]:
		node.hide()
		if node == active_menu:
			node.show()


func _on_play_pressed() -> void:
	ActiveMenu = Menus.PLAY
	if true: # FIXME: Replace with a condition to test if there are any stored saves
		set_active_menu(Load)
	else:
		_on_new_pressed()


func _on_new_pressed() -> void:
	ActivePlay = PlayMenus.NEW
	set_active_menu(New)


func _on_options_pressed() -> void:
	ActiveMenu = Menus.OPTIONS
	set_active_menu(Options)


func _on_audio_pressed() -> void:
	ActiveOptions = OptionsMenus.AUDIO
	set_active_menu(Audio)


func _on_video_pressed() -> void:
	ActiveOptions = OptionsMenus.VIDEO
	set_active_menu(Video)


func _on_mods_pressed() -> void:
	ActiveMenu = Menus.MODS
	set_active_menu(Mods)


func _on_back_pressed() -> void:
	match ActiveMenu:
		Menus.PLAY:
			match ActivePlay:
				PlayMenus.LOAD:
					ActiveMenu = Menus.MAIN
					set_active_menu(Main)
				PlayMenus.NEW:
					ActivePlay = PlayMenus.LOAD
					set_active_menu(Load)
		Menus.OPTIONS:
			match ActiveOptions:
				OptionsMenus.NONE:
					ActiveMenu = Menus.MAIN
					set_active_menu(Main)
				OptionsMenus.AUDIO or OptionsMenus.VIDEO:
					ActiveOptions = OptionsMenus.NONE
					set_active_menu(Options)
		Menus.MODS:
			match ActiveMods:
				ModsMenus.NONE:
					ActiveMenu = Menus.MAIN
					set_active_menu(Main)
				ModsMenus.MODS or ModsMenus.PACKS:
					ActiveMods = ModsMenus.NONE
					set_active_menu(Mods)


func _on_quit_pressed() -> void:
	get_tree().quit()
