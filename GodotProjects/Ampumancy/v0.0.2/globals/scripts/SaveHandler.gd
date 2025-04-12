extends Node

var saves: DirAccess
var sys_saves_path: String = "res://data/saves/"
var level_data: DirAccess = DirAccess.open("res://data/saves/default/level_data/")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	var dir = DirAccess.open("user://")
	dir.make_dir("saves")
	saves = DirAccess.open("user://saves/")


func create_new_save(save_name: String, player_name: String) -> void:
	var save_being_copied: String = sys_saves_path + "default/"
	if OS.is_debug_build() and player_name == "MAX_SAVE":
		save_being_copied = sys_saves_path + "max_save/"
		level_data = DirAccess.open(save_being_copied + "level_data/")
	
	var new_save: SaveData = load(save_being_copied + "save.tres")
	new_save.SAVENAME = save_name
	new_save.PLAYER.NAME = player_name
	
	create_directories(save_name)
	for file in level_data.get_files():
		ResourceSaver.save(ResourceLoader.load(save_being_copied + "level_data/" + file), "user://saves/" + save_name + "/level_data/" + file)
	
	save_to_disk(new_save)
	load_from_disk(new_save.SAVENAME)


func create_directories(save_name: String) -> void:
	saves.make_dir_recursive(save_name + "/level_data/")


func save_settings() -> void:
	ResourceSaver.save(Globals.SETTINGS, "user://settings/Settings.tres")
	print("Settings saved!")


func save_level_data() -> void:
	ResourceSaver.save(Globals.MAIN.DATA, "user://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + Globals.MAIN.name.to_lower() + ".tres")
	print("Level data saved!")


func delete_from_disk(save_name: String) -> void:
	for dir in DirAccess.get_directories_at("user://saves/"):
		if save_name == dir:
			print(OS.move_to_trash(ProjectSettings.globalize_path("user://saves/" + save_name)))
			return


func save_to_disk(data: SaveData = Globals.SAVE) -> void:
	data.PLAYTIME += Time.get_ticks_msec() - Globals.PLAY_START
	Globals.PLAY_START = Time.get_ticks_msec()
	ResourceSaver.save(data, "user://saves/" + data.SAVENAME + "/save.tres")
	print("Game saved!")


func load_from_disk(save_name: String) -> void:
	Globals.SAVE = ResourceLoader.load("user://saves/" + save_name + "/save.tres")
	print("Save loaded!")
