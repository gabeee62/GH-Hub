extends Node

var Database: DirAccess = DirAccess.open("user://")

var SaveLocation: String = "user://Saves/"
var DebugLocation: String = "res://Server/Data/Saves/Templates/"
var SettingsLocation: String = "user://Settings/Settings.tres"


func convert_to_json() -> void: # TODO: Convert save data into JSON files for better file security
	pass


func load_settings() -> void:
	if not Database.dir_exists("Settings"):
		Database.make_dir("Settings")
		var settings: SettingsData = SettingsData.new()
		Globals.Settings = settings
		save_settings()
	if not Database.dir_exists("Mods"):
		Database.make_dir("Mods")
	else:
		Globals.Settings = ResourceLoader.load(SettingsLocation)
		save_settings()


func save_settings() -> void:
	ResourceSaver.save(Globals.Settings, SettingsLocation)


func new_save(SaveName: String) -> SaveData:
	var NewSave: SaveData = ResourceLoader.load("res://Server/Data/Saves/Default_Save.tres").duplicate()
	NewSave.SaveName = SaveName
	DirAccess.make_dir_absolute(SaveLocation + SaveName)
	save_game(NewSave)
	return NewSave


func save_game(SaveFile: SaveData) -> void:
	ResourceSaver.save(SaveFile, SaveLocation + SaveFile.SaveName + "/" + "Save.tres")


func delete_save(data: SaveData) -> void:
	var saves: DirAccess = DirAccess.open(SaveLocation)
	saves.remove(data.SaveName + "/Save.tres")
	saves.remove(data.SaveName)
