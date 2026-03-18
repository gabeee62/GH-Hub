extends Node

# TODO: Make save and load functions

var SaveLocation: String = "user://Saves/"


func save_game(SaveFile: SaveData) -> void:
	ResourceSaver.save(SaveFile, SaveLocation + SaveFile.SaveName + "/" + "Save.tres")


func new_game(SaveName: String) -> SaveData:
	var NewSave: SaveData = SaveData.new()
	NewSave.SaveName = SaveName
	DirAccess.make_dir_absolute(SaveLocation + SaveName)
	save_game(NewSave)
	return NewSave


func load_game() -> void:
	get_tree().change_scene_to_file(Globals.CurrentSave.CurrentZone)


func delete_save(data: SaveData) -> void:
	var saves: DirAccess = DirAccess.open(SaveLocation)
	saves.remove(data.SaveName + "/Save.tres")
	saves.remove(data.SaveName)
