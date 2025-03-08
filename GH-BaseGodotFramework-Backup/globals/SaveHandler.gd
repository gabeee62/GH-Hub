extends Node

#              --- ABOUT ---
# This script provides a global access point 
# for all game saves. Contains methods for 
# saving and loading save data to the disk.


func _ready() -> void:
	DirAccess.make_dir_absolute(Global.save_dir_path)


# Creates a new save file (filled with the default save data), loads it to Global.SAVE, and starts the game.
func create_new_save(filepath: String):
	var save_dir: DirAccess = DirAccess.open(Global.save_dir_path)
	
	# CREATING NEW SAVE DIRECTORIES
	save_dir.make_dir(filepath)
	save_dir.make_dir(filepath + "/level_data")
	
	# COPYING DEFAULT SAVE FILES TO NEW SAVE
	for file in DirAccess.get_files_at(Global.save_dir_path + "default"):
		save_dir.copy(Global.save_dir_path + "default/" + file, Global.save_dir_path + filepath + "/" + file)
	for file in DirAccess.get_files_at(Global.save_dir_path + "default/level_data/"):
		save_dir.copy(Global.save_dir_path + "default/level_data/" + file, Global.save_dir_path + filepath + "/level_data/" + file)
	
	# LOADING NEW SAVE TO ACTIVE SAVE + ENSURING THAT IT HAS ITS FILENAME ATTRIBUTE
	load_from_disk(Global.save_dir_path + filepath + "/save.tres")
	Global.SAVE.filename = filepath
	save_to_disk()
	
	print("NEW SAVE FILE CREATED AT " + filepath.to_upper() + "\n")


# Saves the [current level's data] as its respective [LevelData file] inside the current save's [level_data directory].
func save_level_data():
	ResourceSaver.save(Global.MAIN.level_data, "res://saves/" + Global.SAVE.filename + "/level_data/" + Global.MAIN.level_data.filename + ".tres")
	print("SYSTEM: Level data saved!")


# Loads the specified save from the disk, and gives it to Global.SAVE for processing.
func load_from_disk(filepath: String):
	Global.SAVE = ResourceLoader.load(filepath)
	SignalBus.change_scene.emit(Global.SAVE.current_level_path, Util.SCENE_CHANGE_TYPES.FB, true)


# Saves the current game save inside Global.SAVE as save.tres to the save directory matching its filename attribute.
func save_to_disk():
	# Only saves level data if the Global main var has been set (meaning the level has been fully loaded)
	if Global.MAIN:
		save_level_data()
	# Only saves player data if the Global player var has been set (meaning the player has been fully loaded)
	if Global.PLAYER:
		Global.SAVE.player_data = Global.PLAYER.data
	Global.SAVE.settings_data = Global.SAVE.settings_data # REPLACE WITH SETTINGS SCENE'S CURRENT COPY OF SETTINGS DATA ONCE CREATED
	ResourceSaver.save(Global.SAVE, Global.save_dir_path + Global.SAVE.filename + "/save.tres")
	print("SYSTEM: SAVE FILE " + Global.SAVE.filename + " SAVED TO DISK")
