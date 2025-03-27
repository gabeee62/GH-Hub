extends Node

var default_save: DirAccess = DirAccess.open("res://saves/default/")
var level_data: DirAccess = DirAccess.open("res://saves/default/level_data/")
var saves: DirAccess = DirAccess.open("res://saves/")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func create_new_save(save_name: String, player_name: String) -> void:
	var default_data: SaveData = ResourceLoader.load("res://saves/default/save.tres")
	default_data.SAVENAME = save_name
	default_data.PLAYER.NAME = player_name
	
	saves.make_dir_recursive(save_name + "/level_data/")
	for file in level_data.get_files():
		ResourceSaver.save(ResourceLoader.load("res://saves/default/level_data/" + file + ".tres"), "res://saves/" + save_name + "/level_data/" + file + ".tres")
	
	save_to_disk(default_data)
	load_from_disk(default_data.SAVENAME)


func save_level_data() -> void:
	ResourceSaver.save(Globals.MAIN.DATA, "res://saves/" + Globals.SAVE.SAVENAME + "/level_data/" + Globals.MAIN.name.to_lower() + ".tres")


func save_to_disk(data: SaveData = Globals.SAVE) -> void:
	ResourceSaver.save(data, "res://saves/" + data.SAVENAME + "/save.tres")


func load_from_disk(save_name: String) -> void:
	Globals.SAVE = ResourceLoader.load("res://saves/" + save_name + "/save.tres")
