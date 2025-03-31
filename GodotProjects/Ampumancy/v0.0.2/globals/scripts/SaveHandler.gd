extends Node

var default_save: DirAccess = DirAccess.open("res://saves/default/")
var level_data: DirAccess = DirAccess.open("res://saves/default/level_data/")
var saves: DirAccess = DirAccess.open("res://saves/")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func create_new_save(save_name: String, player_name: String) -> void:
	var new_save: SaveData = ResourceLoader.load("res://saves/default/save.tres")
	new_save.SAVENAME = save_name
	new_save.PLAYER.NAME = player_name
	
	create_directories(save_name)
	for file in level_data.get_files():
		ResourceSaver.save(ResourceLoader.load("res://saves/default/level_data/" + file), "res://saves/" + save_name + "/level_data/" + file)
	
	save_to_disk(new_save)
	load_from_disk(new_save.SAVENAME)


func create_directories(save_name: String) -> void:
	saves.make_dir_recursive(save_name + "/level_data/")


func save_level_data() -> void:
	ResourceSaver.save(Globals.MAIN.DATA, "res://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + Globals.MAIN.name.to_lower() + ".tres")
	print("Level data saved!")


func save_to_disk(data: SaveData = Globals.SAVE) -> void:
	ResourceSaver.save(data, "res://saves/" + data.SAVENAME + "/save.tres")
	print("Game saved!")


func load_from_disk(save_name: String) -> void:
	Globals.SAVE = ResourceLoader.load("res://saves/" + save_name + "/save.tres")
	print("Save loaded!")
